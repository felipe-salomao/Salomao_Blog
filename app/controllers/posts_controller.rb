class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  
  def index
    @highlights = Post.desc_order.first(3)

    current_page = (params[:page] || 1).to_i
    highlight_ids = @highlights.pluck(:id).join(',')

    @posts = Post.without_highlights(highlight_ids)
                 .desc_order
                 .page(current_page).per(3)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(permitted_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(permitted_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def permitted_params
    params.require(:post).permit(:title, :description)
  end
end