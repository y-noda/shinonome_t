class QuestionnaireAnswersController < ApplicationController
  # POST /questionnaire_answers
  # POST /questionnaire_answers.json
  def create
    @confirming = params[:confirming]
    if params[:category_id]
      @questionnaire_answer = QuestionnaireAnswer.find_by(user_id: current_user.id, category_id: params['category_id'])
      if @questionnaire_answer.nil?
        @questionnaire_answer = QuestionnaireAnswer.new(
        category_id: params['category_id'],
        user: current_user,
        answer: params['answer']
        )
        @questionnaire_answer.save
      end

      set_questionnaire_answers

    else
      @questionnaire_answer = LastQuestionnaireAnswer.find_by(user_id: current_user.id)
      if @questionnaire_answer.nil?
        @questionnaire_answer = LastQuestionnaireAnswer.new(
        user: current_user,
        answer: params['answer']
        )
        @questionnaire_answer.save
      end

      set_last_questionnaire_answers
    end

  end

  # PATCH/PUT /questionnaire_answers/1
  # PATCH/PUT /questionnaire_answers/1.json
  def update
    @confirming = params[:confirming]
    if params[:category_id]
      @questionnaire_answer = QuestionnaireAnswer.find_by(user_id: current_user.id, category_id: params['category_id'])
      @questionnaire_answer.update(
      category_id: params['category_id'],
      user: current_user,
      answer: params['answer']
      )
      @questionnaire_answer.save

      set_questionnaire_answers

    else
      @questionnaire_answer = LastQuestionnaireAnswer.find_by(user_id: current_user.id)
      @questionnaire_answer.update(
      user: current_user,
      answer: params['answer']
      )
      @questionnaire_answer.save

      set_last_questionnaire_answers

    end
  end

  private

  def set_questionnaires
    @questionnaires = [
      Questionnaire.new(
      question: "動画教材の閲覧や、教材のダウンロードなどの動作について、どう感じましたか。",
      choice_a: "①　満足である",
      choice_b: "②　やや満足である",
      choice_c: "③　少し不満である",
      choice_d: "④　不満である",
      question_type: "radio",
      order: 1
    ),

    Questionnaire.new(
      question: "問１で③、④を選択された方は、その理由をお答えください。（複数回答可）",
      choice_a: "①　今回のｅラーニングに限り、動画がなめらかに映し出されなかったから。",
      choice_b: "②　今回のｅラーニングに限り、教材のダウンロードに時間がかかったから。",
      choice_c: "③　その他",
      # ここ本来は選択肢3つだけの上に、3つめの選択肢は自由回答
      choice_d: "",
      question_type: "checkbox",
      order: 2
    ),

    Questionnaire.new(
      question: "今後もｅラーニングを利用した研修があれば受講したいと思いますか。",
      choice_a: "①　そう思う",
      choice_b: "②　ややそう思う",
      choice_c: "③　あまり思わない",
      choice_d: "④　思わない",
      question_type: "radio",
      order: 3
    ),

    Questionnaire.new(
      question: "問３で①、②を選択された方にお聞きします。今後、ｅラーニングを利用した研修として、どのような研修内容を望まれますか。",
      choice_a: "",
      choice_b: "",
      choice_c: "",
      choice_d: "",
      question_type: "free",
      order: 4
    ),

    Questionnaire.new(
      question: "問３で①、②を選択された方は、その理由をお答えください。（複数回答可）",
      choice_a: "①　どこにいても受講できるから",
      choice_b: "②　自分が受講したいときに受講できるから",
      choice_c: "③　重要だと思うところを繰り返して受講することができるから",
      choice_d: "④　その他", # 4つめの選択肢は自由回答
      question_type: "checkbox",
      order: 5
    ),

    Questionnaire.new(
      question: "問３で③、④を選択された方は、その理由をお答えください。（複数回答可）",
      choice_a: "①　パソコンやスマートフォンでの操作が難しいから",
      choice_b: "②　インターネットがつながる環境にいないことが多いから",
      choice_c: "③　教育研究所に出向いて受講したいから",
      choice_d: "④　その他", # 4つめの選択肢は自由回答
      question_type: "checkbox",
      order: 6
    ),

    Questionnaire.new(
      question: "今回のｅラーニングを利用した研修において、研修内容や操作方法などについて具体的な改善点を書いてください。",
      choice_a: "",
      choice_b: "",
      choice_c: "",
      choice_d: "",
      question_type: "free",
      order: 7
    ),

    Questionnaire.new(
      question: "今回のｅラーニングを利用した研修を受講した感想を書いてください。",
      choice_a: "",
      choice_b: "",
      choice_c: "",
      choice_d: "",
      question_type: "free",
      order: 8
    )
    ]
  end

  def set_questionnaire_answers

    @category = Category.find(params[:category_id])
    @item_prop_title_1 = @category.title
    @item_prop_title_2 = "初任者研修講座に関するアンケート"
    @description = @category.format_short_description('')

    @breadcrumbs = []
    @breadcrumbs << ['TOP', '/top']
    @breadcrumbs << ['講座一覧', categories_path]
    @breadcrumbs << ['初任者研修講座', categories_path]
    @breadcrumbs << [@item_prop_title_2, '']

    if @confirming === 'confirming'
      @questionnaire_answer.post_completion = true
      @questionnaire_answer.save
      set_thanks
      render template: 'questionnaires/thanks'
      return
    end

    @questionnaires = Questionnaire.where(category: @category)
    @confirming = input_completion? ? 'ok' : 'ng'

    if @confirming === 'ok'
      @amend_link = category_questionnaires_path(@category)
      @confirming = 'confirming'
      render template: 'questionnaires/index'
    else
      @result_text_1 = '記入されていない箇所があります。'
      @result_text_2 = '　記入されていない箇所がある場合は、アンケートは送信できません。全て記入して送信してください。'
      @result_link_text = ''
      @result_link = ""
      render template: 'questionnaires/index'
    end
  end

  def set_last_questionnaire_answers

    @item_prop_title_1 = ""
    @item_prop_title_2 = "ｅラーニングを活用した研修についてのアンケート"
    @description = ""

    @breadcrumbs = []
    @breadcrumbs << ['TOP', '/top']
    @breadcrumbs << ['講座一覧', categories_path]
    @breadcrumbs << [@item_prop_title_2, '']

    if @confirming === 'confirming'
      @questionnaire_answer.post_completion = true
      @questionnaire_answer.save
      @bold_text = "ｅラーニングを活用した研修についての"
      @link_url = '/top'
      @link_title = 'ｅラーニングのスタートページへ'
      @thanks_message = 'おつかれさまでした。<br>これでｅラーニング研修「初任者研修講座」はすべて終了しました。'
      render template: 'questionnaires/thanks'
      return
    end

    set_questionnaires
    @confirming = input_completion? ? 'ok' : 'ng'

    if @confirming === 'ok'
      @amend_link = last_questionnaire_path
      @confirming = 'confirming'
      render template: 'questionnaires/index'
    else
      @result_text_1 = '記入されていない箇所があります。'
      @result_text_2 = '　記入されていない箇所がある場合は、アンケートは送信できません。全て記入して送信してください。'
      @result_link_text = ''
      @result_link = ""
      render template: 'questionnaires/index'
    end
  end

  def set_thanks
    categories = Category.all
    count = 0
    categories.each do |category|
      answer = QuestionnaireAnswer.find_by(category_id: category.id, user_id: current_user.id)
      if !answer.nil? && answer.post_completion
        count += 1
      end
    end
    if count === categories.length
      @bold_text = "初任者研修講座#{@category.title}に関する"
      @link_url = last_questionnaire_path
      @link_title = 'アンケートへ'
      @thanks_message = 'これでｅラーニング研修「初任者研修講座」はすべて終了しました。おつかれさまでした。<br>最後にこのeラーニングを活用した研修についてのアンケートに答えてください。'
    else
      @bold_text = "初任者研修講座#{@category.title}に関する"
      @link_url = categories_path
      @link_title = '講座一覧へ'
      @thanks_message = 'お疲れさまでした。<br>他の講座を受講しましょう。'
    end
  end

  def input_completion?
    if params[:category_id].nil?
      return last_questionnaire_completion?
    end

    answer = params[:answer]
    count = 0
    @questionnaires.each_with_index do |questionnaire, index|
      if questionnaire.is_radio?
        count += 1
      elsif questionnaire.is_checkbox?
        count += 1
        for choice_index in 1..4
          if questionnaire.get_question(choice_index).include?("その他")
            count += 1
            checkbox = answer["checkbox_#{index}"]
            if checkbox.present? && checkbox.find {|n| n === choice_index.to_s}.present?
              if free_answer_empty?(answer["checkbox_#{index}_free"])
                return false
              end
            end
          end
        end
      else
        count += 1
        if !(questionnaire.order == 3) && free_answer_empty?(answer["free_#{index}"])
          return false
        end
      end
    end
    return answer.permit!.to_hash.length === count
  end

  def last_questionnaire_completion?
    answer = params[:answer]
    

    answer_check_type = [
      {need: true, check_index: 0, check_values: []},
      {need: false, check_index: 0, check_values: [3, 4]},
      {need: true, check_index: 0, check_values: []},
      {need: false, check_index: 2, check_values: [1, 2]},
      {need: false, check_index: 2, check_values: [1, 2]},
      {need: false, check_index: 2, check_values: [3, 4]},
      {need: true, check_index: 0, check_values: []},
      {need: true, check_index: 0, check_values: []},
    ]

    @questionnaires.each_with_index do |questionnaire, index|
      _answer = answer["#{questionnaire.question_type}_#{index}"]
      if answer_check_type[index][:need]
        if _answer.blank?
          return false
        else
          next
        end
      end

      check_answer = answer["#{@questionnaires[answer_check_type[index][:check_index]].question_type}_#{answer_check_type[index][:check_index]}"]
      check_values = answer_check_type[index][:check_values]
      have_value = false
      check_values.each do |val|
        if check_answer === val.to_s
          have_value = true
        end
      end

      if have_value
        if _answer.blank?
          return false
        end
        if questionnaire.is_checkbox?
          for choice_index in 1..4
            if questionnaire.get_question(choice_index).include?("その他")
              if _answer.present? && _answer.find {|n| n === choice_index.to_s}.present?
                if free_answer_empty?(answer["checkbox_#{index}_free"])
                  return false
                end
              end
            end
          end
        elsif questionnaire.is_free?
          if free_answer_empty?(_answer)
            return false
          end
        end
      end

    end

    true
  end

  def free_answer_empty?(answer)
    if answer.strip.blank?
      return true
    end
    return false
  end

end
