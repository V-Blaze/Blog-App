class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      author: current_user,
      title: params[:post][:title],
      text: params[:post][:text]
    )
    
    if @post.save
      redirect_to users_path
    else
      render :new
    end
  end

end
