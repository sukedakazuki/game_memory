class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @review = Review.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @reviews = Review.all
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review), notice: "You have created review successfully."
    else
      @reviews = Review.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to review_path(@review), notice: "You have updated review successfully."
    else
      render "edit"
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:rate, :comment)
  end

  def ensure_correct_user
    @review = Review.find(params[:id])
    unless @review.user == current_user
      redirect_to reviews_path
    end
  end
end
