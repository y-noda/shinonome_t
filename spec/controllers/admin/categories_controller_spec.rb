require_relative './admin_controller_shared_examples.rb'

RSpec.describe Admin::CategoriesController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CategoriesController. Be sure to keep this updated too.
  let!(:model) { create(:category) }
  let(:model_symbol) { :category }
  let(:model_symbols) { :categories }
  let(:model_class) { Category }
  let(:model_columns) { { :title => 'aieeeee!' } }
  let(:category) { model }
  let(:get_params) { {} }
  let(:post_params) { { category: attributes_for(:category) } }
  let(:patch_params) { { id: category, category: attributes_for(:category, model_columns) } }
  let(:delete_params) { { id: category } }
  let(:updated_redirect) { admin_categories_path }

  it_behaves_like 'admin_controller_tests'
end
