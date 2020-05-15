class Checksheet < ApplicationRecord 
  validates :question, presence: true
  validates :answer_type, presence: true

  has_many :video_checksheets
  has_many :videos, through: :video_checksheets

  def is_radio?
    self.answer_type === "radio"
  end

  def is_checkbox?
    self.answer_type === "checkbox"
  end

  def is_freedom?
    self.answer_type === "freedom"
  end

  def is_correct?(answer)
    if is_radio?
      return correct === answer
    elsif is_checkbox?
      return correct.split(",") === answer
    else
      if answer.strip.blank?
        return false
      end
      return true
    end
  end

  def get_choice(index)
    case index
    when 1
      self.choice_a
    when 2
      self.choice_b
    when 3
      self.choice_c
    when 4
      self.choice_d
    end
  end
end
