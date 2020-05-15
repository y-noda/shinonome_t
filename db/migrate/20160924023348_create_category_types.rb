class CreateCategoryTypes < ActiveRecord::Migration
  def change
    create_table :category_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
