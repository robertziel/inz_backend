class AddAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :street, :string
    add_column :users, :zip_code, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :phone, :string

    add_column :orders, :street, :string, null: false
    add_column :orders, :zip_code, :string, null: false
    add_column :orders, :city, :string, null: false
    add_column :orders, :country, :string, null: false
    add_column :orders, :phone, :string, null: false
  end
end
