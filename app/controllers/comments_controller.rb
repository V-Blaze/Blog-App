class CommentsController < ApplicationController
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

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post: current_user.posts.find(params[:post_id]))
  end
end
