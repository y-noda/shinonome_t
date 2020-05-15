class CreateChecksheetAnswers < ActiveRecord::Migration
  def change
    create_table :checksheet_answers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :checksheet, index: true, foreign_key: true
      t.boolean :correct_answer, default: false

      t.timestamps null: false
    end
  end
end
