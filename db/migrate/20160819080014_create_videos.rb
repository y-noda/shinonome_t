class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :category, index: true
      t.attachment :videofile
      t.text :description, null: false
      t.attachment :worksheet
      t.attachment :slide
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
