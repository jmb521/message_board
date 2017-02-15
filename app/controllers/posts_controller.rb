class PostsController < ApplicationController
before_action :set_user, :authorize
  def index
    @posts = Post.all

  end

  def show

    @post = Post.find_by(id: params[:id])
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def new

    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      
      redirect_to posts_path
    else
      redirect_to new_post_path
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
