class Questionnaire < ApplicationRecord 
  validates :question, presence: true

  belongs_to :category

  def is_radio?
    self.question_type == "radio"
  end

  def is_checkbox?
    self.question_type == "checkbox"
  end

  def is_free?
    self.question_type == "free"
  end

  def get_question(index)
    case index
    when 1
      self.choice_a
    when 2
      self.choice_b
    when 3
      self.choice_c
    else
      self.choice_d
    end
  end
end
