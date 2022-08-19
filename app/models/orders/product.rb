class Orders::Product < ApplicationRecord
  self.table_name = :order_products

  belongs_to :order
  belongs_to :product, class_name: 'Item'
end
