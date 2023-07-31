class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @new = Review.new
    @new.game_id = params[:game_id]
    @game = Game.find(params[:game_id])
  end

  def create
    @new = Review.new(review_params)
    @new.user_id = current_user.id
    if @new.save
      flash[:notice] = "You have created review successfully."
      redirect_to users_information_path
    else
      @user = current_user
      redirect_to new_review_path
    end
  end

  def show
    @review = Review.find(params[:id])
    @post_comment = PostComment.new
    @user = User.find(current_user.id)
  end

  def index
    @review = Review.page(params[:page]).per(5)
    @user = User.find(current_user.id)
    if params[:latest]
      @reviews = Review.latest
    elsif params[:old]
      @reviews = Review.old
    else
      @reviews = Review.all
    end
  end

  def edit
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review), notice: "You have updated review successfully."
    else
      render "edit"
    end
  end

  def destroy
    @review.destroy
    redirect_to users_information_path, notice: "You have destroyed review successfully."
  end

  private

  def review_params
    params.require(:review).permit(:rate, :comment, :user_id, :game_id)
  end

  def ensure_correct_user
    @review = Review.find(params[:id])
    unless @review.user == current_user
      redirect_to reviews_path
    end
  end
end
