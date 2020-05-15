class AddPostCompletionToQuestionnaireAnswer < ActiveRecord::Migration
  def change
    add_column :questionnaire_answers, :post_completion, :boolean
  end
end
