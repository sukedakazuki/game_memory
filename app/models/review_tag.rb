# frozen_string_literal: true

class ReviewTag < ApplicationRecord
  has_many :review_and_tags, dependent: :destroy
  has_many :reviews, through: :review_and_tags

  validates :name, presence: true, length: { maximum: 50 }
end
