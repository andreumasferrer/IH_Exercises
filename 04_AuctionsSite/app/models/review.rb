class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  #belongs_to :reviewed_product, class_name: "Product", foreign_key: "product_id"
end
