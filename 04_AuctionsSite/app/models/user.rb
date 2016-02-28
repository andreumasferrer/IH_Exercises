class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_many :bids
  has_many :reviews, dependent: :destroy
  has_many :reviewed_products, through: :reviews

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
end
