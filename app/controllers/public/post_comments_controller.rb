class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.review_id = @review.id
    @comment.save
    redirect_to review_path(@review)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to review_path(params[:review_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
  def ensure_correct_user
    @review = Review.find(params[:id])
    unless @review.user == current_user
      redirect_to reviews_path
    end
  end
end
