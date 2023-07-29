class Game < ApplicationRecord
  self.primary_key = "jan"
  has_many :reviews, dependent: :destroy
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @game = Game.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @game = Game.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @game = Game.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @game = Game.where("title LIKE?","%#{word}%")
    else
      @game = Game.all
    end
  end
end
