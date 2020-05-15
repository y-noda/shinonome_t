class ChangeColumnToChecksheet < ActiveRecord::Migration
  def change
    remove_column :checksheets, :isfreedom
    add_column :checksheets, :answer_type, :string
    add_column :checksheets, :correct, :string
  end
end
