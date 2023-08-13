# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game, primary_key: "jan"
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :review_and_tags, dependent: :destroy
  has_many :review_tags, through: :review_and_tags

  validates :comment, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :rate_count, -> { order(rate: :desc) }

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("comment LIKE?", "#{word}")
    elsif search == "forward_match"
      @review = Review.where("comment LIKE?", "#{word}%")
    elsif search == "backward_match"
      @review = Review.where("comment LIKE?", "%#{word}")
    elsif search == "partial_match"
      @review = Review.where("comment LIKE?", "%#{word}%")
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

  def save_review_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.review_tags.pluck(:name) unless self.review_tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.review_tags.delete ReviewTag.find_by(name: old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      review_tag = ReviewTag.find_or_create_by(name: new_name)
      self.review_tags << review_tag
    end
  end
end
