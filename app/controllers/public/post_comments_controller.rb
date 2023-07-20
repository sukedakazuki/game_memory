class Public::PostCommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.review_id = review.id
    @comment.save
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
