class ChecksheetAnswersController < ApplicationController
  protect_from_forgery :except => [:draft]
  # POST /checksheet_answers/draft
  def draft
    answer_params = checksheet_answer_params
    answer = ChecksheetAnswer.find_or_create_by(user_id: answer_params[:user_id], video_id: answer_params[:video_id])
    answer.answer = answer_params[:answer]
    answer.save

    render body: nil, status: 200
  end

  private

  def checksheet_answer_params
    params.permit(:user_id, :video_id).tap do |permitted|
      permitted[:answer] = params[:answer] if params[:answer].is_a?(Hash)
    end
  end
end
