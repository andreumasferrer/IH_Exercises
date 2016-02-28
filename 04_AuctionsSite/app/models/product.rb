class Product < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  validates :user_id, :title, presence: true

  def highest_persisted_bid
    bids.all.max_by{|b| b.amount}
  end

  def higher_than_highest?(bid_amount)
    return bid_amount > (highest_persisted_bid.nil? ? 0 : highest_persisted_bid.amount)
  end

  def higher_or_eq_minimum?(bid_amount)
    return bid_amount >= (minimum_bid.nil? ? 0 : minimum_bid)
  end

end
