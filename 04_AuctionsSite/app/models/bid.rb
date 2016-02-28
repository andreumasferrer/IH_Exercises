class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :product_id, :user_id, :amount, presence: true

  validate :amount_must_be_highest_bid, on: :create
  validate :amount_must_be_higher_or_eq_than_minimum, on: :create
  validate :user_cannot_be_the_owner_of_the_product

  private

  def amount_must_be_highest_bid
    unless product.higher_than_highest?(amount)
      errors.add(:amount, 'Amount must be the highest bid')
    end
  end

  def amount_must_be_higher_or_eq_than_minimum
    unless product.higher_or_eq_minimum?(amount)
      errors.add(:amount, 'must be the higher or equal than the minimum bid')
    end
  end

  def user_cannot_be_the_owner_of_the_product
    if user_id == product.user_id
      errors.add(:user_email, 'cannot bid on their own products!')
    end
  end


end
