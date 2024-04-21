class PostsController < ApplicationController
  include Paginable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_categories, only: %i[index new create edit update]
  
  def index
    @archives = Post.group_by_month(:created_at, format: '%B %Y', locale: :en).count
  
    category = @categories.find { |c| c.name == params[:category] } if params[:category].present?
    month_year = @archives.find { |m| m[0] == params[:month_year] }&.first if params[:month_year].present?

    @highlights = Post.includes(:category, :user)
                      .filter_by_category(category)
                      .filter_by_archive(month_year)
                      .asc_order
                      .first(3)

    highlight_ids = @highlights.pluck(:id).join(',')

    @posts = Post.includes(:category, :user)
                 .without_highlights(highlight_ids)
                 .filter_by_category(category)
                 .filter_by_archive(month_year)
                 .desc_order
                 .page(current_page)
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])

    if @post.nil?
      redirect_to new_post_path, alert: t('helpers.select.prompt')
    else
      authorize @post
    end
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(permitted_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(permitted_params)
      redirect_to @post, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: t('.success')
  end

  def attachment_create
    file = params[:post][:attachment_file]
    category_id = params[:post][:category_id]
  
    if file
      file_path = Rails.root.join('tmp', file.original_filename)
      File.open(file_path, 'wb') do |f|
        f.write(file.read)
      end
  
      ProcessPostJob.perform_later(current_user.id, file_path.to_s, category_id)
      
      redirect_to root_path, notice: t('.success')
    else
      redirect_to new_post_path, alert: t('helpers.select.prompt')
    end
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