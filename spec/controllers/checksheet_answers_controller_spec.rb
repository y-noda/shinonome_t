require 'rails_helper'

RSpec.describe ChecksheetAnswersController, type: :controller do
  describe 'POST #draft' do
    let(:user) { create(:user) }
    let(:video) { create(:video) }
    let(:answer_attrs) { attributes_for(:checksheet_answer, user: user, video: video) }

    let(:post_params) do
      {
        user_id: user.id,
        video_id: video.id,
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

    it 'ChecksheetAnswer を DB に保存する' do
      expect {
        post :draft, post_params
      }.to change(ChecksheetAnswer, :count).by(1)
    end

    context '既に保存された ChecksheetAnswer があるとき' do
      let(:update_answer) { { this: 'is', json: { with: 'any', structure: '!!!' } } }
      let(:update_params) do
        {
          user_id: user.id,
          video_id: video.id,
          answer: update_answer
        }
      end

      before do
        post :draft, post_params
      end

      it '新しい ChecksheetAnswer を DB に保存しない' do
        expect {
          post :draft, update_params
        }.not_to change(ChecksheetAnswer, :count)
      end

      it '既存の ChecksheetAnswer を更新する' do
        post :draft, update_params

        answer = ChecksheetAnswer.find_by(user_id: user.id, video_id: video.id)
        expect(answer.answer).to eq(JSON(update_answer.to_json))
      end
    end
  end
end
