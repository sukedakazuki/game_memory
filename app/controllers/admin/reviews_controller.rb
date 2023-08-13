# frozen_string_literal: true

class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_review, only: [:show, :edit, :update]

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    @tag_list = @review.review_tags.pluck(:name).join(",")
    @review_tags = @review.review_tags
  end

  def edit
    @review = Review.find(params[:id])
    @tag_list = @review.review_tags.pluck(:name).join(",")
  end

  def update
    @review = Review.find(params[:id])
    tag_list = params[:review][:name].split(",")
    if @review.update(review_params)
      @review.save_review_tags(tag_list)
      redirect_to admin_review_path(@review)
      flash[:notice] = "レビューの編集に成功しました。"
    else
      flash.now[:alart_flash] = "レビューの編集に失敗しました。"
      render "edit"
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_reviews_path
  end

  private
    def review_params
      params.require(:review).permit(:user_id, :game_id, :rate, :comment, :is_deleted)
    end

    def ensure_review
      @review = Review.find(params[:id])
    end
end
