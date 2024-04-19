class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.comments.create(permitted_params.to_h.merge!({ user_id: current_user.id }))
    redirect_to post_path(@post), notice: 'Comment was successfully created.'
  end

  def destroy
    comment = @post.comments.find(params[:id])
    authorize comment

    comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully destroyed.'
  end

  private

  def permitted_params
    params.require(:comment).permit(:body, :anonymous)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
