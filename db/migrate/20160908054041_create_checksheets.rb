class CreateChecksheets < ActiveRecord::Migration
  def change
    create_table :checksheets do |t|
      t.string :question
      t.string :choice_a
      t.string :choice_b
      t.string :choice_c
      t.string :choice_d
      t.boolean :isfreedom, default: false

      t.timestamps null: false
    end
  end
end
