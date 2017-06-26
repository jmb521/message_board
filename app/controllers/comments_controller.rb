class CommentsController < ApplicationController
before_action :authorize, :set_post, :set_comment

  def index
      @comments = @post.comments
      respond_to do |format|
        format.html {render 'index'}
        format.js { render 'index.js' }
      end
  end

  def new
    @comment = Comment.new

  end


  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    # if @comment.save
    #   redirect_to post_path(@comment.post_id)
    #
    # else
    #   redirect_to posts_path, notice: "Your comment couldn't be saved"
    # end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update

    @comment.update(comment_params)
    redirect_to post_path(@comment.post_id)
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@comment.post_id)
  end
  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
  def set_post
    @post = Post.find_by(:id => params[:post_id])
  end
  def set_comment
   @comment = Comment.find_by(id: params[:id])
 end
end
