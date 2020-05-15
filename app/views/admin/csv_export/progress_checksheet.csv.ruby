require 'kconv'
require 'csv'

header = ["ユーザID", "講座名", "講座ID"] + 3.times.map {|i| ["C_#{i+1}_MOVIE", "C_#{i+1}_CS", "C_#{i+1}_COMPLETE"]}.flatten + ["ENQ", "CS_1_1", "CS_1_2", "CS_1_3", "CS_2_1", "CS_2_2", "CS_2_3", "CS_3_1", "CS_3_2", "CS_3_3"]

CSV.generate do |csv|
  csv << header

  User.all.each do |user|
    next if user.administrator
    next if /\At_/ =~user.name
    next if /\Ad_/ =~user.name
    next if /\Ao_/ =~user.name

    Category.all.includes(:videos).each do |category|
      row = [user.name, category.title, category.id]

      row = row + category.videos.order(:category_id, :order).map do |video|
        [video.watched?(user) ? 1 : 0, video.checksheet_answered?(user) ? 1 : 0, video.checksheet_complete?(user) ? 1 : 0]
      end.flatten

      row = row + [category.questionnaire_complete?(user) ? 1 : 0]

      Video.where(category: category).order(:order).each do |video|
        checksheet_answer = ChecksheetAnswer.find_by(user: user, video: video)
        unless checksheet_answer.nil?
          unless checksheet_answer.answer.nil?
            checksheet_answer.answer.map do |key, val|
              if val.instance_of?(Array)
                row << val.map{|v| v.to_i}
              else
                row << val
              end
            end
            if checksheet_answer.answer.length < 3
              row << ''
            end
          end
        end
      end

      csv << row
    end
  end
end.tosjis
