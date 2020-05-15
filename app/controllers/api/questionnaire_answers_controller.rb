class Api::QuestionnaireAnswersController < ApplicationController
  protect_from_forgery :except => [:draft]

  # POST /questionnaire_answers/draft
  def draft
    answer_params = questionnaire_answer_params
    answer = QuestionnaireAnswer.find_or_create_by(user_id: answer_params[:user_id], category_id: answer_params[:category_id])
    answer.answer = answer_params[:answer]
    answer.save

    render body: nil, status: 200
  end

  private

  def questionnaire_answer_params
    params.permit(:user_id, :category_id, answer: [:free_0, :free_1, :free_2])
  end
end
