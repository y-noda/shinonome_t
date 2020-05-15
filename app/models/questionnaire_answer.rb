class QuestionnaireAnswer < ApplicationRecord 
  belongs_to :category
  belongs_to :user

  def is_checked?(answer_type, index, value)
    if answer.blank?
      return false
    end
    if answer["#{answer_type}_#{index}"].nil?
      return false
    end

    case answer_type
    when 'radio'
      answer["#{answer_type}_#{index}"] === value.to_s
    when 'checkbox'
      answer["#{answer_type}_#{index}"].find {|n| n === value.to_s}.present?
    else
      return false
    end
  end

  def checkbox_free_answer(index)
    if answer.nil?
      return ""
    end
    answer["checkbox_#{index}_free"]
  end

  def free_answer(index)
    if self.answer.nil?
      ""
    else
      self.answer["free_#{index}"]
    end
  end
end
