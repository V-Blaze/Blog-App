class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(
      post: current_user.posts.find(params[:post_id]),
      author: current_user,
      text: params[:text]
    )

    if @comment.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end
end
