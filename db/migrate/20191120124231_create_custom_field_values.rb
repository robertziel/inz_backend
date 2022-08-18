class CreateCustomFieldValues < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_field_values do |t|
      t.references :item, null: false, foreign_key: true, index: true
      t.references :custom_field, null: false, foreign_key: true, index: true
      t.index %i[item_id custom_field_id], unique: true

      t.string :value

      t.timestamps
    end
  end
end
