module Api
  class CategoryFiltersSerializer < ApplicationSerializer
    attributes :category_filters

    def category_filters
      return [] if object.nil?

      object.inherited_custom_fields_array.map do |custom_field|
        custom_field.slice(:datatype, :id, :name)
      end
    end
  end
end
