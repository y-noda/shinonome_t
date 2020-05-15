require 'rails_helper'

RSpec.describe Api::QuestionnaireAnswersController, type: :controller do
  describe 'POST #draft' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:answer_attrs) { attributes_for(:checksheet_answer, user: user, category: category) }

    let(:post_params) do
      {
        user_id: user.id,
        category_id: category.id,
        answer: answer_attrs
      }
    end

    before do
      login_user(user)
    end

    it 'http success を返す' do
      post :draft, post_params
      expect(response).to have_http_status(:success)
    end

    it 'QuestionnaireAnswer を DB に保存する' do
      expect {
        post :draft, post_params
      }.to change(QuestionnaireAnswer, :count).by(1)
    end

    context '既に保存された QuestionnaireAnswer があるとき' do
      let(:update_answer) { { this: 'is', json: { with: 'any', structure: '!!!' } } }
      let(:update_params) do
        {
          user_id: user.id,
          category_id: category.id,
          answer: update_answer
        }
      end

      before do
        post :draft, post_params
      end

      it '新しい QuestionnaireAnswer を DB に保存しない' do
        expect {
          post :draft, update_params
        }.not_to change(QuestionnaireAnswer, :count)
      end

      it '既存の QuestionnaireAnswer を更新する' do
        post :draft, update_params

        answer = QuestionnaireAnswer.find_by(user_id: user.id, category_id: category.id)
        expect(answer.answer).to eq(JSON(update_answer.to_json))
      end
    end

    context 'ログインしていないとき' do
      before do
        logout_user
      end

      it 'リダイレクトする' do
        post :draft, post_params
        expect(response).to redirect_to(:root)
      end
    end
  end
end
