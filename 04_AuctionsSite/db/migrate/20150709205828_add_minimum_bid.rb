class AddMinimumBid < ActiveRecord::Migration
  def change
    add_column :products, :minimum_bid, :decimal, :precision => 8, :scale => 2
  end
end
