class CreateLastQuestionnaireAnswers < ActiveRecord::Migration
  def change
    create_table :last_questionnaire_answers do |t|
      t.references :user
      t.json :answer
      t.boolean :post_completion, default: false

      t.timestamps null: false
    end
  end
end
