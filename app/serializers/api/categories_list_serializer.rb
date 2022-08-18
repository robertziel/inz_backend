module Api
  class CategoriesListSerializer < ApplicationSerializer
    attributes :current_category, :parent_category, :subcategories

    def current_category
      return nil if object.nil?

      category_hash(object)
    end

    def parent_category
      return nil if object&.parent.nil?

      category_hash(object.parent)
    end

    def subcategories
      subcategories = object ? object.subcategories : Category.head_categories
      subcategories.map { |subcategory| category_hash(subcategory) }
    end

    private

    def category_hash(category)
      {
        id: category.id,
        name: category.name
      }
    end
  end
end
