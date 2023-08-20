class Public::RanksController < ApplicationController
  before_action :authenticate_user!
  def rank
    #  投稿のいいね数週間ランキング
    @favorite_ranks = Review.find(Favorite.group(:review_id).where(created_at: Time.current.all_month).order('count(review_id) desc').pluck(:review_id))
    @reviews = Review.page(params[:page])
  end
end