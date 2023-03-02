class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)

    return unless @like.save

    redirect_to "/users/#{@post.author.id}/posts/#{@post.id}"
  end
end
