class AddSomeColumnToCategory < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.string :category_type
      t.string :short_description
      t.text :description
    end
  end
end
