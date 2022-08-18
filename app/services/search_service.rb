class SearchService
  attr_accessor :price, :name

  def initialize(search_params)
    @category_filters_values = search_params[:category_filters_values]
    @category_id = search_params[:category_id]
    @price_range = search_params[:price] || {}
    @name = search_params[:name]
  end

  def perform
    items = Item
    items = items.where('price >= ?', @price_range[:from]) if @price_range[:from].present?
    items = items.where('price <= ?', @price_range[:to]) if @price_range[:to].present?
    items = items.where( "name LIKE '%#{@name}%'") if @name.present?

    if @category_id.present?
      items = belongs_to_any_subcategory(items)
      items = search_on_custom_fields(items) if @category_filters_values.present?
      items.uniq
    else
      items.all
    end
  end

  private

  def belongs_to_any_subcategory(items)
    all_categiries_ids = Category.find_with_all_children(@category_id).pluck(:id)
    items.where(category_id: all_categiries_ids)
  end

  def search_on_custom_fields(items)
    category = Category.find(@category_id)
    items = items.joins(:custom_field_values)

    category.inherited_custom_fields_array.each do |custom_field|
      value = @category_filters_values["category_filter_#{custom_field.id}"]
      next unless value.present?

      belongs_to_custom_field_sql = "custom_field_values.custom_field_id = #{custom_field.id}"

      case custom_field.datatype
      when CustomField::FLOAT

        items = items.where(
          "#{belongs_to_custom_field_sql} AND custom_field_values.value::FLOAT >= #{value[:from]}"
        ) if value[:from].present?

        items = items.where(
          "#{belongs_to_custom_field_sql}  AND custom_field_values.value::FLOAT <= #{value[:to]}"
        ) if value[:to].present?

      when CustomField::STRING
        items = items.where("custom_field_values.custom_field_id = #{custom_field.id} AND custom_field_values.value LIKE '%#{value}%'")
      end
    end

    items
  end
end
