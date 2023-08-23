class Public::RanksController < ApplicationController
  before_action :authenticate_user!
  def rank
    # 投稿のいいね数週間ランキング
    @favorite_ranks = Review.find(Favorite.group(:review_id).where(created_at: Time.current.all_month).limit(10).order('count(review_id) desc').pluck(:review_id))
    # 投稿のコメント数週間ランキング
    @post_comment_ranks = Review.find(PostComment.group(:review_id).limit(10).order('count(review_id) desc').pluck(:review_id))
  end
end