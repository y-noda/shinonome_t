class AddSelectionQuestionnaires < ActiveRecord::Migration
  def change
    change_table(:questionnaires) do |t|
      t.string :choice_a
      t.string :choice_b
      t.string :choice_c
      t.string :choice_d
      t.string :question_type

      t.integer :order
    end

    create_table(:questionnaire_answers) do |t|
      t.references :user
      t.references :category
      t.json :answer

      t.timestamps null: false
    end
  end
end
