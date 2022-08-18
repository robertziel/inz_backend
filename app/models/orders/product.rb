class Orders::Product < ApplicationRecord
  self.table_name = :order_product

  belongs_to :order
end
