class CreateVideoChecksheets < ActiveRecord::Migration
  def change
    create_table :video_checksheets do |t|
      t.references :video, index: true, foreign_key: true
      t.references :checksheet, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end
