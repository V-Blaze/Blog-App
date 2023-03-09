class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to root_path, notice: 'Comment was successfully deleted.'
  end

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post: current_user.posts.find(params[:post_id]))
  end
end
