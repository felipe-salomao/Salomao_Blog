class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = policy_scope(Category.sorted)
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit; end

  def create
    @category = Category.new(permitted_params)
    authorize @category

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: t('app.create.success', model: Category.model_name.human) }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(permitted_params)
        format.html { redirect_to categories_url, notice: t('app.update.success', model: Category.model_name.human) }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: t('app.destroy.success', model: Category.model_name.human) }
        format.json { head :no_content }
      end
    else
      redirect_to categories_url, alert: @category.errors.messages[:base][0]
    end
  end

  private

  def permitted_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end
end
