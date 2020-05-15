class ChecksheetsController < ApplicationController
  before_action :set_checksheet, only: [:create]

  def index
    @video = Video.find(params[:video_id])
    category_id = @video[:category_id]
    @category = Category.find(category_id)

    answered_all_checksheet?

    if @need_questionnaire && @video.order == 3
      set_result(2)
    end

    @checksheet_answer = ChecksheetAnswer.find_by(user_id: current_user.id, video_id: params[:video_id])
    if @video.order != 1
      videos = Video.where(category_id: category_id).order(:order)
      videos.each do |video|
        if video.order < @video.order
          answer = ChecksheetAnswer.find_by(user_id: current_user.id, video_id: video.id)
          if answer.nil? || !answer.correct_answer
            redirect_to "/categories/#{category_id}/videos"
            return
          end
        end
      end
    end

    if !@video.watched?(current_user)
      redirect_to "/videos/#{@video.id}"
      return
    end

    set_checksheet
    create_breadcrumbs
  end

  def create

    is_correct = true
    is_allfree = true

    answer = params["answer"] || {}

    @checksheets.each_with_index do |checksheet, index|
      is_correct &= checksheet.is_correct?(answer["#{checksheet.answer_type}#{index}"])
      is_allfree &= checksheet.is_freedom?
    end

    @need_questionnaire = false

    # 今回の結果を保存する
    checksheet_answer = ChecksheetAnswer.find_by(user_id: current_user.id, video_id: @video.id)
    checksheet_answer = ChecksheetAnswer.new(user_id: current_user.id, video_id: @video.id) if checksheet_answer.nil?

    checksheet_answer.answer = answer
    checksheet_answer.correct_answer |= is_correct

    checksheet_answer.save

    @checksheet_answer = checksheet_answer

    answered_all_checksheet?

    if is_correct
      set_result(@need_questionnaire ? 2 : 1)
    else
      set_result(is_allfree ? 4 : 3)
    end

    create_breadcrumbs
    render action: 'index'
  end

  private

  def create_breadcrumbs
    @video ||= Video.find_by(id: params[:video_id])

    @breadcrumbs = []
    @breadcrumbs << ['TOP', '/top']
    @breadcrumbs << ['講座一覧', categories_path]
    @breadcrumbs << ['初任者研修講座', categories_path]
    @breadcrumbs << [@chapter_title, video_path(@video)]
    @breadcrumbs << ['チェックシート', "/checksheets?video_id=#{@video.id}" ]
  end

    def set_checksheet
      @video = Video.find(params[:video_id])
      category_id = @video[:category_id]
      @category = Category.find(category_id)
      video_checksheets = VideoChecksheet.where(video_id: @video.id).order(:order)
      @checksheets = []
      video_checksheets.each do |video_checksheet|
        @checksheets << Checksheet.find(video_checksheet.checksheet_id)
      end

      @chapter_number = "#{(9 - @video.id) % 3 + 1}"
      @chapter_title = @video.title
      if category_id == 1
        @chapter_type = 'チャプター'
      elsif category_id == 2
        @chapter_type = 'チャプター'
      else
        @chapter_type = '研修項目'
      end
    end

    def set_result(result)
      case result
      when 1
        @result_text_1 = '次のチャプターへ進むことができます。'
        @result_text_2 = 'すべてのチャプターの終了後、初任者研修講座に関するアンケートを記入して、提出してください。'
        @result_link_text = 'チャプター一覧'
        @result_link = "/categories/#{@category.id}/videos"
        @is_correct = true
      when 2
        @result_text_1 = 'アンケートへ進むことができます。'
        @result_text_2 = 'すべてのチャプターが終了しました、初任者研修講座に関するアンケートを記入して、提出してください。'
        @result_link_text = 'アンケートへ'
        @result_link = "/categories/#{@category.id}/questionnaires"
        @is_correct = true
      when 3
        @result_text_1 = '未記入またはチェック内容が適切でない箇所があります。'
        @result_text_2 = '　チェック内容が全て適切ならば次のチャプターへ進むことができます。未記入箇所があった場合やチェック内容が適切でない箇所があった場合は、チャプターを終了することができず、次へ進むことができません。「動画視聴ページ戻る」ボタンをクリックし、動画を視聴するか、チェックシートをもう一度やり直してください。'
        @result_link_text = '動画視聴ページに戻る'
        @result_link = "/videos/#{@video.id}"
      when 4
        @result_text_1 = '記入されていない箇所があります。'
        @result_text_2 = '　記入されていない箇所がある場合は、チェックシートは送信できません。全て記入して送信してください。送信が完了すれば次のチャプターへ進むことができます。'
        @result_link_text = 'チャプター一覧'
        @result_link = "/categories/#{@category.id}/videos"
      else
        @result_text_1 = '未記入またはチェック内容が適切でない箇所があります。'
        @result_text_2 = '　チェック内容が全て適切ならば次のチャプターへ進むことができます。未記入箇所があった場合やチェック内容が適切でない箇所があった場合は、チャプターを終了することができず、次へ進むことができません。「動画視聴ページ戻る」ボタンをクリックし、動画を視聴するか、チェックシートをもう一度やり直してください。'
        @result_link_text = 'チャプター一覧'
        @result_link = "/categories/#{@category.id}/videos"
      end

    end

    def answered_all_checksheet?
      @videos = Video.where(category: @category)
      correct_count = 0
      @videos.each do |video|
        checksheet_answer = ChecksheetAnswer.find_by(user_id: current_user.id, video_id: video.id)
        if checksheet_answer.nil?
          next
        end
        if checksheet_answer.correct_answer
          correct_count += 1
        end
      end
      @need_questionnaire = correct_count === @videos.length
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checksheet_params
      params.require(:checksheet).permit(:question, :choice_a, :choice_b, :choice_c, :choice_d, :answer_type, :correct)
    end
end
