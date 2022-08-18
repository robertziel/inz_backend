class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, class_name: 'Orders::Product'
end
