class User < ApplicationRecord 
  authenticates_with_sorcery!

  validates :name, presence: true, uniqueness: true
  validates :password, presence: { on: :create }, confirmation: { allow_blank: true }

  has_many :checksheet_answers, dependent: :destroy
  has_many :progresses, dependent: :destroy
  has_many :questionnaire_answers, dependent: :destroy
  has_one :last_questionnaire_answer, dependent: :destroy

  def last_questionnaire_complete?
    self.last_questionnaire_answer.try(:post_completion)
  end

  def enable_last_questionnaire?
    Category.all.each do |category|
      unless category.questionnaire_complete?(self)
        return false
      end
    end

    !last_questionnaire_complete?
  end
end
