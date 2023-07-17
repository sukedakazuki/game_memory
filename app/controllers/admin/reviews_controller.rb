class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_review, only: [:show, :edit, :update]

  def index
    @reviews = Review.page(params[:page])
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
  end

  def update
    @review.update(review_params) ? (redirect_to admin_review_path(@review)) : (render :edit)
  end
  
  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :game_id, :rate, :comment)
  end

  def ensure_review
    @review = Review.find(params[:id])
  end
end
