class Admin::CategoryTypesController < Admin::Base
  before_action :set_category_type, only: [:show, :edit, :update, :destroy]

  # GET /category_types
  # GET /category_types.json
  def index
    @category_types = CategoryType.all
  end

  # GET /category_types/1
  # GET /category_types/1.json
  def show
  end

  # GET /category_types/new
  def new
    @category_type = CategoryType.new
    @text = '作成'
  end

  # GET /category_types/1/edit
  def edit
    @text = '更新'
  end

  # POST /category_types
  # POST /category_types.json
  def create
    @category_type = CategoryType.new(category_type_params)

    respond_to do |format|
      if @category_type.save
        format.html { redirect_to admin_categories_path, notice: 'Category type was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /category_types/1
  # PATCH/PUT /category_types/1.json
  def update
    respond_to do |format|
      if @category_type.update(category_type_params)
        format.html { redirect_to admin_categories_path, notice: 'Category type was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /category_types/1
  # DELETE /category_types/1.json
  def destroy
    @category_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: 'Category type was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_type
      @category_type = CategoryType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_type_params
      params.require(:category_type).permit(:title)
    end
end
