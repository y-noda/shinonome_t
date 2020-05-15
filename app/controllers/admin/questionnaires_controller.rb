class Admin::QuestionnairesController < Admin::Base
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy]

  # GET /questionnaires
  # GET /questionnaires.json
  def index
    # @questionnaires = Questionnaire.all
    @category = Category.find(params[:category_id])
    @questionnaires = @category.questionnaires
  end

  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
  end

  # GET /questionnaires/new
  def new
    @category = Category.find(params[:category_id])
    @questionnaire = Questionnaire.new
  end

  # GET /questionnaires/1/edit
  def edit
  end

  # POST /questionnaires
  # POST /questionnaires.json
  def create
    @category = Category.find(params[:category_id])
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.category = @category

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to admin_category_questionnaires_path(@category), notice: 'Questionnaire was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /questionnaires/1
  # PATCH/PUT /questionnaires/1.json
  def update
    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to admin_category_questionnaires_path(@category), notice: 'Questionnaire was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /questionnaires/1
  # DELETE /questionnaires/1.json
  def destroy
    @questionnaire.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_questionnaires_path(@category), notice: 'Questionnaire was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
      @category = @questionnaire.category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questionnaire_params
      params.require(:questionnaire).permit(:category_id, :question)
    end
end
