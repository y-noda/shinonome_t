class Category < ApplicationRecord 
  validates :title, presence: true
  validates :short_description, presence: false
  validates :description, presence: false

  belongs_to :category_type
  has_many :questionnaires
  has_many :questionnaire_answers
  has_many :videos

  def format_short_description(replace)
    short_description.gsub(/,/, replace)
  end

  def questionnaire_complete?(user)
    user.questionnaire_answers.find_by(category: self).try(:post_completion)
  end

  def enable_questionnaire?(user)
    Video.where(category: self).each do |video|
      unless ChecksheetAnswer.find_by(user_id: user.id, video_id: video.id).try(:correct_answer)
        return false
      end
    end
    !questionnaire_complete?(user)
  end
end
