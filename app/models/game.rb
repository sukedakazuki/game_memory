# frozen_string_literal: true

class Game < ApplicationRecord
  self.primary_key = "jan"
  has_many :reviews, dependent: :destroy
end
