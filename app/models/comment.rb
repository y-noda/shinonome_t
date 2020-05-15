class Comment < ApplicationRecord 
  belongs_to :video
  belongs_to :user

  def deletable?(user)
    user.administrator || (user.id == self.user.id)
  end
end
