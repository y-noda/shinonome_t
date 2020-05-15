require 'rails_helper'

shared_examples_for 'admin_controller_tests' do
  let(:valid_session) { {} }
  let(:admin_user) { create(:administrator) }

  before do
    login_user admin_user
  end

  describe "GET #index" do
    before do
      get :index, get_params, valid_session
    end

    it "indexとして表示するためにモデルが設定されているか" do
      expect(assigns(model_symbols)).to eq([model])
    end

    it 'index テンプレートを表示する' do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    it "モデルを追加する" do
      expect{
        post :create, post_params
      }.to change(model_class, :count).by(1)
    end

    it "追加後 index に遷移する" do
      post :create, post_params
      expect(response).to redirect_to updated_redirect
    end
  end

  describe "PATCH #update" do
    it "要求したモデルが配置される" do
      patch :update, patch_params
      expect(assigns(model_symbol)).to eq model
    end

     it "モデルを更新する" do
      patch :update, patch_params
      model.reload
      model_columns.each do |key, value|
        expect(model.send(key)).to eq(value)
      end
    end

    it "更新後 index に遷移する" do
      patch :update, patch_params
      expect(response).to redirect_to updated_redirect
    end
  end

  describe "DELETE #destroy" do
    it "モデルを削除する" do
      expect{
        delete :destroy, delete_params
      }.to change(model_class, :count).by(-1)
    end

    it "更新後 index に遷移する" do
      delete :destroy, delete_params
      expect(response).to redirect_to updated_redirect
    end
  end
end
