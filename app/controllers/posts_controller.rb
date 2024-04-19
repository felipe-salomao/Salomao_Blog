class PostsController < ApplicationController
  include Paginable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_categories, only: %i[new create edit update]
  
  def index
    @categories = Category.sorted
    category = @categories.select { |c| c.name == params[:category] }[0] if params[:category].present?

    @highlights = Post.includes(:category, :user)
                      .filter_by_category(category)
                      .filter_by_archive(params[:month_year])
                      .desc_order
                      .first(3)

    highlight_ids = @highlights.pluck(:id).join(',')

    @posts = Post.includes(:category, :user)
                 .without_highlights(highlight_ids)
                 .filter_by_category(category)
                 .filter_by_archive(params[:month_year])
                 .desc_order
                 .page(current_page)

    @archives = Post.group_by_month(:created_at, format: '%B %Y').count
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    authorize @post
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(permitted_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(permitted_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: 'Post was successfully destroyed.'
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :description, :category_id)
  end

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def set_categories
    @categories = Category.sorted
  end
end