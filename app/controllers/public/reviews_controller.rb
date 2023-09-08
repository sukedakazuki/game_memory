# frozen_string_literal: true

class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @new = Review.new
    @new.game_id = params[:game_id]
    @game = Game.find(params[:game_id])
    @tag_list = @new.review_tags.pluck(:name).join(",")
  end

  def create
    @new = Review.new(review_params)
    @new.user_id = current_user.id
    tag_list = params[:review][:name].split(",")
    if @new.save
      @new.save_review_tags(tag_list)
      flash[:notice] = "レビュー投稿に成功しました。"
      redirect_to users_information_path
    else
      @user = current_user
      flash.now[:alart_flash] = "レビューの投稿に失敗しました。"
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @post_comment = PostComment.new
    @user = User.find(@review.user_id)
    @tag_list = @review.review_tags.pluck(:name).join(",")
    @review_tags = @review.review_tags
  end

  def search_tag
    # 検索結果画面でもタグ一覧表示
    @tag_list = ReviewTag.all
    # 検索されたタグを受け取る
    @tag = ReviewTag.find(params[:review_tag_id])
    # 検索されたタグに紐づく投稿を表示
    @reviews = @tag.reviews.page(params[:page])
  end

  def index
    @reviews = Review.page(params[:page])
    @tag_list = ReviewTag.all
    @user = User.find(current_user.id)
    if params[:latest]
      @reviews = Review.latest.page(params[:page])
    elsif params[:old]
      @reviews = Review.old.page(params[:page])
    elsif params[:rate_count]
      @reviews = Review.rate_count.page(params[:page])
    else
      @reviews = Review.page(params[:page])
    end
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
      redirect_to review_path(@review)
      flash[:notice] = "レビューの編集に成功しました。"
    else
      flash.now[:alart_flash] = "レビューの編集に失敗しました。"
      render "edit"
    end
  end

  def destroy
    @review.destroy
    redirect_to users_information_path
    flash[:notice] = "レビューを削除しました。"
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
