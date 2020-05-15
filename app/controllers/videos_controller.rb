class VideosController < ApplicationController
  layout "ignore_layout", only: [:video]

  # GET /videos
  # GET /videos.json
  def index
    @category = Category.find(params[:category_id])
    @videos = Video.where(category: @category).order(:order)

    @breadcrumbs = []
    @breadcrumbs << ['TOP', '/top']
    @breadcrumbs << ['講座一覧', categories_path]
    @breadcrumbs << ['初任者研修講座']
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
    @category = @video.category
    if @category.id === 3
      @chapter_text = '研修項目'
      @to_checksheet_text = '　動画を最後まで視聴した後、チェックシートに進んでください。記入されていない箇所がある場合は、チェックシートは送信できません。全て記入して送信してください。'
    else
      @chapter_text = 'チャプター'
      @to_checksheet_text = '　動画を最後まで視聴した後、チェックシートに進んでください。チェック内容がすべて適切ならば、このチャプターは終了です。未記入箇所があった場合やチェック内容が適切でない箇所があった場合は、チャプターを終了することができず、次へ進むことができません。「動画視聴ページに戻る」ボタンをクリックし、動画を視聴するか、チェックシートをもう一度やり直してください。'
    end
    @comments = @video.comments.includes(:user)
    @comment = Comment.new
    @current_user = current_user
  end

  # GET /video
  def video
    @video = Video.find(params[:video_id])
    @category = Category.find(@video.category.id)
    render action: 'video_iframe'
  end
end
