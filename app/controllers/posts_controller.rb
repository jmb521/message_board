class PostsController < ApplicationController
before_action :authorize, :set_post
  def index
    @posts = Post.all.order('created_at ASC').reverse_order

    @post = Post.new
    render json: @posts

  end

  def show
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

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :comment_attributes => [:content, :user_id])
  end
  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
