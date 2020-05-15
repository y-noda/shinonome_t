require 'rails_helper'

RSpec.describe Admin::VideosController, type: :controller do
  let!(:model) { create(:video) }
  let(:model_symbol) { :video }
  let(:model_symbols) { :videos }
  let(:model_class) { Video }
  let(:model_columns) { { :title => 'aieeeee!', :description => 'hogeeeee!' } }
  let(:video) { model }
  let(:category) { video.category }
  let(:get_params) { { category_id: category.id } }
  let(:post_params) { { video: attributes_for(:video), category_id: category.id } }
  let(:patch_params) { { id: video, video: attributes_for(:video, model_columns) } }
  let(:delete_params) { { id: video } }
  let(:updated_redirect) { admin_category_videos_path(category) }

  it_behaves_like 'admin_controller_tests'
end
