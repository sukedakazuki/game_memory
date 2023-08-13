# frozen_string_literal: true

class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.review_id = @review.id
    @comment.save
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    @comment = PostComment.find_by(id: params[:id], review_id: params[:review_id])
    @comment.destroy
    redirect_to review_path(@review)
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment, :user_id, :review_id)
    end
end
