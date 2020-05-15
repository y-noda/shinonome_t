require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  include Sorcery::TestHelpers::Rails::Controller

  let(:valid_session) { {} }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'index テンプレートを表示する' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    let(:password) { 'password' }

    context '正当なパラメータで POST するとき' do
      context '一般ユーザの場合' do
        let(:general) { create(:user) }

        before do
          post :create, { name: general.name, password: password }, valid_session
        end

        it 'アプリ側のTOPページにリダイレクトする' do
          expect(response).to redirect_to '/top'
        end
      end

      context '管理者の場合' do
        let(:admin) { create(:administrator) }

        before do
          post :create, { name: admin.name, password: password }, valid_session
        end

        it '管理側のTOPページにリダイレクトする' do
          expect(response).to redirect_to admin_csv_export_index_path
        end
      end
    end

    context '不正なパラメータで POST するとき' do
      context '一般ユーザの場合' do
        let(:general) { create(:user) }

        before do
          post :create, { name: general.name, password: nil }, valid_session
        end

        it 'ルートにリダイレクトする' do
          expect(response).to redirect_to root_path
        end

        it 'IDとパスワードが一致しませんというflashを出す' do
          expect(flash[:alert]).to eq('ユーザー名とパスワードが一致しません')
        end
      end

      context '管理者の場合' do
        let(:admin) { create(:administrator) }

        before do
          post :create, { name: admin.name, password: nil }, valid_session
        end

        it 'ルートにリダイレクトする' do
          expect(response).to redirect_to root_path
        end

        it 'IDとパスワードが一致しませんというflashを出す' do
          expect(flash[:alert]).to eq('ユーザー名とパスワードが一致しません')
        end
      end
    end

    describe 'DELETE #destroy' do
      context '一般ユーザがログアウトするとき' do
        let(:general) { create(:user) }

        before do
          login_user(general)
          delete :destroy, { id: general.id }, valid_session
        end

        it 'ルートにリダイレクトする' do
          expect(response).to redirect_to root_path
        end
      end

      context '管理者がログアウトするとき' do
        let(:admin) { create(:administrator) }

        before do
          login_user(admin)
          delete :destroy, { id: admin.id }, valid_session
        end

        it 'ルートにリダイレクトする' do
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
