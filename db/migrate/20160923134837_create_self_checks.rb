class CreateSelfChecks < ActiveRecord::Migration
  def change
    create_table :self_checks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.json :answer

      t.timestamps null: false
    end
  end
end
