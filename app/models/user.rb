class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reviews
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  has_one_attached :profile_image
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
