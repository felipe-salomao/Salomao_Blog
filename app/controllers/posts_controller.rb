class PostsController < ApplicationController
  include Paginable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  
  def index
    category = Category.find_by_name(params[:category]) if params[:category].present?

    @highlights = Post.filter_by_category(category)
                         .desc_order
                         .first(3)

    highlight_ids = @highlights.pluck(:id).join(',')

    @posts = Post.without_highlights(highlight_ids)
                 .filter_by_category(category)
                 .desc_order
                 .page(current_page)

    @categories = Category.sorted
  end

  def show; end

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

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def permitted_params
    params.require(:post).permit(:title, :description, :category_id)
  end
end