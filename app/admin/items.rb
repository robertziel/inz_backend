ActiveAdmin.register Item do
  permit_params :name, :description, :price, :category_id,
                custom_field_values_attributes: %i[id value custom_field_id]

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :category

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :category
      row :created_at
      row :updated_at
      item.custom_field_values.each do |custom_field_value|
        row(custom_field_value.custom_field.name) { custom_field_value.value }
      end
    end
    active_admin_comments
  end

  form do |f|
    if params[:category_id].present? &&
       params[:category_id] != f.object.category_id

      f.object.category_id = params[:category_id]
      f.object.custom_field_values = begin
        object.category.inherited_custom_fields_array.map do |custom_field|
          custom_field.custom_field_values.new
        end
      end
    end

    f.inputs do
      f.input :category
      f.input :name
      f.input :description
      f.input :price
      f.has_many :custom_field_values, new_record: false do |cf|
        cf.input :custom_field, input_html: { hidden: true }, label: false
        cf.input :value, label: cf.object.custom_field.name
      end
    end
    f.actions
  end
end
