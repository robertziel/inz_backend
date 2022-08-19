ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :username
      row :email
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
      row :street
      row :zip_code
      row :city
      row :country
      row :phone
      table_for user.orders.order('created_at ASC') do
        column :user
        column :total_price
        column :total_taxed_price
        column :status
        column :created_at
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
