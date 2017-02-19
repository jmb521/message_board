class PostsController < ApplicationController
before_action :set_user, :authorize
  def index
    @posts = Post.all.order('created_at ASC').reverse_order

    @post = Post.new

  end

  def show

    @post = Post.find_by(id: params[:id])

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
    @post = Post.find_by(id: params[:id])

  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :comment_attributes => [:content, :user_id])
  end
end
