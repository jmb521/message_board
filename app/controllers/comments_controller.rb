class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @user = User.find_by(id: params[:id])
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to post_path(@comment.post)
    else
      redirect_to posts_path, notice: "Your comment couldn't be saved"
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    binding.pry
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @comment.update(comment_params)
    redirect_to post_path(@comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
