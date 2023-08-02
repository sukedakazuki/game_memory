class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game, primary_key: "jan"
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :comment,presence:true
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("comment LIKE?", "#{word}")
    elsif search == "forward_match"
      @review = Review.where("comment LIKE?","#{word}%")
    elsif search == "backward_match"
      @review = Review.where("comment LIKE?","%#{word}")
    elsif search == "partial_match"
      @review = Review.where("comment LIKE?","%#{word}%")
    else
      @review = Review.all
    end
  end
  
  def review_status
    if is_deleted == true
      "削除"
    else
      "有効"
    end
  end
end
