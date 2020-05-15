require 'rails_helper'

RSpec.describe SelfChecksController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  let(:valid_attributes) { attributes_for(:self_check, user: user) }
  let(:invalid_attributes) { attributes_for(:self_check, user: user, answer: nil) }

  let(:answer_attrs) { ['0','1','2','3','4','5'] }
  let(:post_params) do
    {
      self_check: {
        user_id: user.id,
        category_id: category.id,
        answer: answer_attrs
      }
    }
  end

  describe "POST #save" do
    before do
      login_user(user)
    end

    it 'http success を返す' do
      post :save, post_params
      expect(response).to have_http_status(:success)
    end

    it 'SelfCheck を DB に保存する' do
      expect {
        post :save, post_params
      }.to change(SelfCheck, :count).by(1)
    end

    context '既に保存された SelfCheck があるとき' do
      let(:update_answer) { ['0','1','2','3','4','5'] }
      let(:update_params) do
        {
          self_check: {
            user_id: user.id,
            category_id: category.id,
            answer: update_answer
          }
        }
      end

      before do
        post :save, post_params
      end

      it '新しい SelfCheck を DB に保存しない' do
        expect {
          post :save, update_params
        }.not_to change(SelfCheck, :count)
      end

      it '既存の SelfCheck を更新する' do
        post :save, update_params

        answer = SelfCheck.find_by(user_id: user.id, category_id: category.id)
        expect(answer.answer).to eq(JSON(update_answer.to_json))
      end
    end
  end
end
