require 'rails_helper'

RSpec.describe Admin::QuestionnairesController, type: :controller do
  include Sorcery::TestHelpers::Rails::Controller

  # This should return the minimal set of attributes required to create a valid
  # Questionnaire. As you add validations to Questionnaire, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuestionnairesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  shared_examples "各アクションのテスト" do
    describe "GET #index" do
      before do
        get :index, { category_id: category.id }, valid_session
      end
      it "@questionnaires に該当する教科カテゴリのアンケート質問リストを設定する" do
        expect(assigns(:questionnaires)).to eq(category.questionnaires)
      end

      it "index テンプレートを表示する" do
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      let(:questionnaire) { create(:questionnaire, category: category) }

      before do
        get :show, { id: questionnaire.id }, valid_session
      end

      it "@questionnaire に要求された質問を設定する" do
        expect(assigns(:questionnaire)).to eq(questionnaire)
      end

      it "show テンプレートを表示する" do
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      before do
        get :new, { category_id: category.id }, session: valid_session
      end

      it "@questionnaire に新規の質問を設定する" do
        expect(assigns(:questionnaire)).to be_a_new(Questionnaire)
      end

      it "new テンプレートを表示する" do
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "@questionnaire に要求された質問を設定する" do
        questionnaire = create(:questionnaire)
        get :edit, { id: questionnaire.id }, valid_session
        expect(assigns(:questionnaire)).to eq(questionnaire)
      end

      it "edit テンプレートを表示する" do
        questionnaire = create(:questionnaire)
        get :edit, { id: questionnaire.id }, valid_session
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      context "パラメータが正しいとき" do
        let(:params) do
          {
            questionnaire: attributes_for(:questionnaire),
            category_id: category.id
          }
        end

        it "質問を保存する" do
          expect {
            post :create, params, valid_session
          }.to change(Questionnaire, :count).by(1)
        end

        it "questionnaires#index にリダイレクトする" do
          post :create, params, valid_session
          expect(response).to redirect_to admin_category_questionnaires_path(category)
        end
      end

      context "パラメータが間違っているとき" do
        let(:params) do
          {
            questionnaire: attributes_for(:questionnaire, question: nil),
            category_id: category.id
          }
        end

        it "質問を保存しない" do
          expect {
            post :create, params, valid_session
          }.not_to change(Questionnaire, :count)
        end

        it "new テンプレートを表示する" do
          post :create, params, valid_session
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before do
        @questionnaire = create(:questionnaire, category_id: category.id)
      end

      context "パラメータが正しいとき" do
        before do
          @questionnaire_params = attributes_for(:questionnaire)
          @questionnaire_params[:question] = "例題"

          patch :update, id: @questionnaire, questionnaire: @questionnaire_params
        end

        it "@questionnaire に要求された質問を設定する" do
          expect(assigns(:questionnaire)).to eq @questionnaire
        end

        it "質問を更新する" do
          @questionnaire.reload
          expect(@questionnaire.question).to eq @questionnaire_params[:question]
        end

        it "questionnaires#index にリダイレクトする" do
          expect(response).to redirect_to admin_category_questionnaires_path(category)
        end
      end

      context "パラメータが間違っているとき" do
        before do
          @questionnaire_params = attributes_for(:questionnaire, question: nil)
          @questionnaire_params[:question] = nil

          patch :update, id: @questionnaire, questionnaire: @questionnaire_params
        end

        it "@questionnaire に要求された質問を設定する" do
          expect(assigns(:questionnaire)).to eq @questionnaire
        end

        it "質問を更新しない" do
          @questionnaire.reload
          expect(@questionnaire.question).not_to eq @questionnaire_params[:question]
        end

        it "edit テンプレートを表示する" do
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before do
        @questionnaire = create(:questionnaire, category_id: category.id)
      end

      it '質問を削除する' do
        expect {
          delete :destroy, id: @questionnaire
        }.to change(Questionnaire, :count).by(-1)
      end

      it 'questionnaires#index にリダイレクトする' do
        delete :destroy, id: @questionnaire
        expect(response).to redirect_to admin_category_questionnaires_path(category)
      end
    end
  end

  describe '管理者によるアクセス' do
    let(:admin) { create(:administrator) }
    let(:category) { create(:category) }

    before do
      login_user(admin)
    end

    it_behaves_like '各アクションのテスト'
  end
end
