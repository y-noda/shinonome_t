require 'kconv'
require 'csv'

CSV.generate do |csv|
  csv << ["ユーザID", "講座名", "講座ID"] + 8.times.map{|i| "回答#{i+1}"} + 8.times.map{|i| "自由回答#{i+1}"}

  User.all.each do |user|
    next if user.administrator
    next if /\At_/ =~user.name
    next if /\Ad_/ =~user.name
    next if /\Ao_/ =~user.name
    
    Category.all.each do |category|
      row = [user.name, category.title, category.id]

      questionnaire_answer = category.questionnaire_answers.where(user: user).first
      if questionnaire_answer.present?
        row = row + questionnaire_answer.answer.map{|k, v| v}
      end

      csv << row
    end

    last_questionnaire_answer = LastQuestionnaireAnswer.where(user: user).order('updated_at desc').first
    answer_row = []
    if last_questionnaire_answer.present?
      last_questionnaire_answer.answer.each do |key, value|
        key_number = key.match(/\d+/).to_s.to_i
        if key.include?("_free")
          answer_row[key_number + 8] = value
        else
          if value.instance_of?(Array)
            answer_row[key_number] = value.map{|v| v.to_i}.join(",")
          else
            answer_row[key_number] = value
          end
        end
      end
    end

    row = [user.name, "eラーニングアンケート", 99] + answer_row

    csv << row
  end
end.tosjis
