# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :comment, presence: true
end
