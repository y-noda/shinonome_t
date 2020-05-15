class AddThumbnailToVideos < ActiveRecord::Migration
  def change
    add_attachment :videos, :thumbnail
    add_column :videos, :minutes, :integer
    add_column :videos, :seconds, :integer
  end
end
