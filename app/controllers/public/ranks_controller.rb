class Public::RanksController < ApplicationController
  before_action :authenticate_user!
  def favorite_rank
    par_page = 10
    @start = ((params[:page] || 1 ).to_i - 1) * par_page + 1
    # 投稿のいいね数週間ランキング
    @favorite_ranks = Kaminari.paginate_array(Review.find(Favorite.group(:review_id).order('count(review_id) desc').pluck(:review_id))).page(params[:page])
  end
  
  def comment_rank
    # 投稿のコメント数週間ランキング
    @comment_ranks = Review.find(PostComment.group(:review_id).limit(10).order('count(review_id) desc').pluck(:review_id))
  end
  
  def game_rank
    # ゲームの評価ランキング
    @game_ranks = Game.find(Review.group(:game_id).order('avg(rate) desc').pluck(:game_id))
  end
end