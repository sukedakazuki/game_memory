class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game, primary_key: "jan"
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :comment,presence:true
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
