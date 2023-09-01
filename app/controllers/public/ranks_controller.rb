class Public::RanksController < ApplicationController
  before_action :authenticate_user!
  def favorite_rank
    # 投稿のいいね数週間ランキング
    @favorite_ranks = Review.find(Favorite.group(:id).limit(10).order('count(review_id) desc').pluck(:id))
  end
  
  def comment_rank
    # 投稿のコメント数週間ランキング
    @comment_ranks = Review.find(PostComment.group(:id).limit(10).order('count(review_id) desc').pluck(:id))
  end
  
  def game_rank
    # ゲームの評価ランキング
    @game_ranks = Game.find(Review.group(:game_id).limit(10).order('avg(rate) desc').pluck(:game_id))
  end
end