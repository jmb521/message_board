class CommentsController < ApplicationController

  def new

    @post_comment = Comment.new(post_id: params[:post_id], user_id: current_user.id)

  end

  def index
    @post_comments = Comment.all

  end

  def create
    @post_comment = Comment.new(comment_params)
    if @post_comment.save
      redirect_to post_comments_path(@post_comment)
    else
      redirect_to posts_path, notice: "Your comment couldn't be saved"
    end
  end

  def edit
    binding.pry
    @post_comment = Comment.find_by(id: params[:id])

  end

  def update
    @post_comment = Comment.find_by(id: params[:id])
    @post_comment.update(comment_params)
    redirect_to post_path(@post_comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
