class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.includes(:posts, :comments).find(params[:user_id])
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(person_params)

    if @post.save
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully deleted.'
  end

  def person_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user)
  end
end
