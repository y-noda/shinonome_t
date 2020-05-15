class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.order(:id)
  end
end
