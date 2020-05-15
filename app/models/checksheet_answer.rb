class ChecksheetAnswer < ApplicationRecord 
  belongs_to :user
  belongs_to :video

  def self.is_correct?(user_id, video_id)
    answer = ChecksheetAnswer.find_by(user_id: user_id, video_id: video_id)
    if answer.nil?
      return false
    else
      return answer.correct_answer
    end
  end

  def is_checked?(answer_type, index, value)
    if answer.blank?
      return false
    end
    if answer["#{answer_type}#{index}"].nil?
      return false
    end

    case answer_type
    when 'radio'
      answer["#{answer_type}#{index}"] === value.to_s
    when 'checkbox'
      answer["#{answer_type}#{index}"].find {|n| n === value.to_s}.present?
    else
      return false
    end
  end

  def get_free_answer(index)
    if answer.blank?
      return ""
    end
    if answer["freedom#{index}"].nil?
      return ""
    else
      answer["freedom#{index}"]
    end
  end
end
