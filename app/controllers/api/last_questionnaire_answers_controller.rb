class Api::LastQuestionnaireAnswersController < ApplicationController
  protect_from_forgery :except => [:draft]

  # POST /last_questionnaire_answers/draft
  def draft
    answer_params = last_questionnaire_answer_params
    answer = LastQuestionnaireAnswer.find_or_create_by(user_id: answer_params[:user_id])
    answer.answer = answer_params[:answer]
    answer.save

    render body: nil, status: 200
  end

  private

  def last_questionnaire_answer_params
    params.permit(:user_id).tap do |permitted|
      permitted[:answer] = params[:answer] if params[:answer].is_a?(Hash)
    end
  end
end
