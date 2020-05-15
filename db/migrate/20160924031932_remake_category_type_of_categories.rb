class RemakeCategoryTypeOfCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :category_type
    add_reference :categories, :category_type, index: true
  end
end
