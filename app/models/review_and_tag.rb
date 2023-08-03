class ReviewAndTag < ApplicationRecord
  belongs_to :review
  belongs_to :review_tag
end
