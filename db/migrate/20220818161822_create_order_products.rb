class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.references :product, null: false
      t.references :order, null: false
      t.integer :amount, null: false
      t.decimal :unit_price, precision: 8, scale: 2, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
