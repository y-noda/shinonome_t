class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to video_path(@comment.video) }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    video = @comment.video

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to video_path(video) }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:video_id, :user_id, :text)
    end
end
