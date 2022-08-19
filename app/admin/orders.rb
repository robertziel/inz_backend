ActiveAdmin.register Order do
  permit_params :status

  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :total_taxed_price
    column :status
    column :created_at
    actions
  end

  filter :user
  filter :total_price
  filter :total_taxed_price
  filter :status
  filter :created_at

  show do
    attributes_table do
      row :user
      row :total_price
      row :total_taxed_price
      row :status
      row :created_at
      row :updated_at
      row :street
      row :zip_code
      row :city
      row :country
      row :phone
      table_for order.products.order('name ASC') do
        column :name
        column :unit_price
        column :amount
        column :product
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :status
    end
    f.actions
  end
end
