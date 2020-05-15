class AddOrderToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :order, :integer
  end
end
