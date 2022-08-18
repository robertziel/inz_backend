class CreateCustomFields < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_fields do |t|
      t.references :category, null: false, foreign_key: true, index: true
      t.string :name, null: false
      t.string :datatype, null: false

      t.timestamps
    end
  end
end
