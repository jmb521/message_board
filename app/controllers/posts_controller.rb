class PostsController < ApplicationController
before_action :authenticate_user
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



  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
