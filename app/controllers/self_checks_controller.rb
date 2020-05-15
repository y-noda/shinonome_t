class SelfChecksController < ApplicationController
  protect_from_forgery :except => [:save]

  # POST /self_checks
  def save
    sc_params = self_check_params
    sc = SelfCheck.find_or_create_by(user_id: sc_params[:user_id], category_id: sc_params[:category_id])
    sc.answer = sc_params[:answer]
    sc.save

    render body: nil, status: 200
  end

  private
    def self_check_params
      params.require(:self_check).permit(:user_id, :category_id).tap do |permitted|
        answer = params[:self_check][:answer]
        permitted[:answer] = answer if answer.is_a?(Array)
      end
    end
end
