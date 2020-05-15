require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:category) { create(:category) }
  let(:general_user) { create(:user) }

  before do
    login_user general_user
  end

  describe "GET #index" do

    before do
      get :index, {}, valid_session
    end

    it "@categories に教科カテゴリリストを設定する" do
      expect(assigns(:categories)).to eq([category])
    end

    it 'index テンプレートを表示する' do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    it "存在しない" do
      expect{
        post :create, category: attributes_for(:category)
      }.to raise_error(AbstractController::ActionNotFound)
    end
  end

  describe "PATCH #update" do
    it "存在しない" do
      expect{
        patch :update, id: category, category: attributes_for(:category)
      }.to raise_error(AbstractController::ActionNotFound)
    end
  end

  describe "DELETE #destroy" do
    it "存在しない" do
      expect{
        delete :destroy, id: category
      }.to raise_error(AbstractController::ActionNotFound)
    end
  end
end
