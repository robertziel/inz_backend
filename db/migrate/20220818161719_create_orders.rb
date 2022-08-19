class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.decimal :total_taxed_price, precision: 8, scale: 2, null: false
      t.string :status

      t.timestamps
    end
  end
end
