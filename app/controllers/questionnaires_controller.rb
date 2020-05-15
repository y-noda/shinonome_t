class QuestionnairesController < ApplicationController
  def index
    @save_api = "/questionnaire_answers/draft"
    @category = Category.find(params[:category_id])
    @item_prop_title_1 = @category.title
    @item_prop_title_2 = "初任者研修講座に関するアンケート"
    @description = @category.format_short_description('')
    @questionnaires = Questionnaire.where(category: @category)
    @questionnaire_answer = QuestionnaireAnswer.where(category: @category, user: current_user).first || QuestionnaireAnswer.new

    create_breadcrumbs
  end

  def last_index
    @save_api = "/last_questionnaire_answers/draft"
    @item_prop_title_1 = ""
    @item_prop_title_2 = "ｅラーニングを活用した研修についてのアンケート"
    @description = ""
    @questionnaire_answer = LastQuestionnaireAnswer.where(user: current_user).first || LastQuestionnaireAnswer.new
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

    create_breadcrumbs
    render action: :index
  end

  private

  def create_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << ['TOP', '/top']
    @breadcrumbs << ['講座一覧', categories_path]
    @breadcrumbs << ['初任者研修講座', categories_path]
    @breadcrumbs << [@item_prop_title_2, '']
  end
end
