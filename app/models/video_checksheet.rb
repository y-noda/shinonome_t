class VideoChecksheet < ApplicationRecord 
  belongs_to :video
  belongs_to :checksheet
end
