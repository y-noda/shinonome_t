class UsersController < ApplicationController
  def mypage
    @user = current_user
    @categories = Category.all.includes(:videos).order(:id)

    @radio_checks = (1..3).map do |category_id|
      self_check = SelfCheck.find_by(user: @user, category_id: category_id)

      empty = (1..6).map { |question_id| (1..5).map { |answer_value| false } }
      next empty if self_check.nil?

      self_check.answer.each_with_index do |answer, i|
        empty[i] = (1..5).map { |answer_value| answer_value == answer.to_i }
      end

      empty
    end

    @radio_check_values = (1..3).map do |category_id|
      self_check = SelfCheck.find_by(user: @user, category_id: category_id)
      next [0,0,0,0,0,0] if self_check.nil?

      self_check.answer.map(&:to_i)
    end

    category_assesments1 = [
      '① Ｒ－ＰＤＣＡサイクルに基づく授業研究の方法について理解している。',
      '② よりよい授業について説明することができる。',
      '③ 授業づくりについて、具体的な手順や方法について理解している。',
      '④ 指導事項に関わって児童の実態把握ができる。',
      '⑤ 学習指導案の書き方について理解している。',
      '⑥ 学習指導案を作成することができる。'
    ]
    category_assesments2 = [
      '① 教育の情報化や情報教育について説明できる。',
      '② ＩＣＴの特長やＩＣＴを活用する意義を理解している。',
      '③ 授業におけるＩＣＴ活用の目的を理解している。',
      '④ 授業においてＩＣＴを活用できる場面を想定することができる。',
      '⑤ インターネットの特性を理解し、情報モラルの指導時に生かすことができる。',
      '⑥ 著作物の保護に関する基礎的な知識を身に付けている。'
    ]
    category_assesments3 = [
      '① 心身の健康問題の把握と保健指導ができる。',
      '② 保健管理を徹底することが重要であることを理解している。',
      '③ 学校安全の基本的事項を理解している。',
      '④ 学校安全活動の推進ができる。',
      '⑤ 学校給食を活用した食育の推進ができる。',
      '⑥ 教育活動における食育の推進ができる。'
    ]

    @assesments = {
      "category_id#{@categories[0].id}" => category_assesments1,
      "category_id#{@categories[1].id}" => category_assesments2,
      "category_id#{@categories[2].id}" => category_assesments3,
    }
  end
end
