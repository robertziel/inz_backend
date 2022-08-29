ActiveAdmin.register Category do
  permit_params :name, :category_id, custom_fields_attributes: %i[id name datatype _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :parent
    actions
  end

  show do
    attributes_table do
      row :name
      row :parent
      row :created_at
      row :updated_at
    end
    panel 'Custom fields' do
      table_for category.custom_fields do
        column :name
        column :datatype
      end
    end
    active_admin_comments
  end

  filter :name
  filter :parent

  form do |f|
    f.inputs do
      f.input :name
      f.input :parent
      f.has_many :custom_fields, allow_destroy: true do |cf|
        cf.input :name
        cf.input :datatype, collection: CustomField::DATATYPES
      end
    end
    f.actions
  end

end
