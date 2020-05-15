class Admin::VideosController < Admin::Base
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @category = Category.find(params[:category_id])
    @videos = Video.where(category: @category)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @category = Category.find(params[:category_id])
    @video = Video.new
    @text = "作成"
  end

  # GET /videos/1/edit
  def edit
    @text = "更新"
  end

  # POST /videos
  # POST /videos.json
  def create
    @category = Category.find(params[:category_id])
    @video = Video.new(video_params)
    @video.category = @category

    respond_to do |format|
      if @video.save
        format.html { redirect_to admin_category_videos_url(@category), notice: 'Video was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to admin_category_videos_url(@category), notice: 'Video was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_videos_url(@category), notice: 'Video was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
      @category = @video.category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :videofile, :worksheet, :slide, :minutes, :seconds, :thumbnail)
    end
end
