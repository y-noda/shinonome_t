class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.references :category, index: true, foreign_key: true
      t.string :question

      t.timestamps null: false
    end
  end
end
