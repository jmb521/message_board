class PostsController < ApplicationController
before_action :set_user, :authorize
  def index
    @posts = Post.all

  end

  def show
    
    @post = Post.find_by(id: params[:id])
  end

  def new

    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      redirect_to new_post_path
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to post_path(@post.id)
  end


  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
