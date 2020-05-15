require 'rails_helper'

RSpec.describe ChecksheetsController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ChecksheetsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  shared_examples '各アクションのテスト' do
  end

  describe '一般ユーザによるアクセス' do
    let(:general) { create(:user) }

    before do
      login_user(general)
    end

    it_behaves_like '各アクションのテスト'
  end
end
