class ProgressesController < ApplicationController
  protect_from_forgery :except => [:create]
  # GET /progresses
  def index
    @progress = Progress.find_by(user_id: params[:user_id], video_id: params[:video_id])
    render json: {result: !@progress.nil?}
  end

  # POST /progresses
  # POST /progresses.json
  def create
    progress = Progress.find_by(progress_params)
    if progress
      render json: {result: true}
      return
    end

    Progress.create(progress_params)
    render json: {result: true}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def progress_params
      params.require(:progress).permit(:video_id, :user_id)
    end
end
