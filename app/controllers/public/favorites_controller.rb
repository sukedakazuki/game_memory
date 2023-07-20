class Public::FavoritesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    @favorite = current_user.favorites.new(review_id: review.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    review = Review.find(params[:review_id])
    @favorite = current_user.favorites.find_by(review_id: review.id)
    @favorite.destroy
    render 'replace_btn'
  end
end
