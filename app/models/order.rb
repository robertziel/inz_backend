class Order < ApplicationRecord
  belongs_to :user
  has_many :products, class_name: 'Orders::Product'
end
