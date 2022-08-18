class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', foreign_key: :category_id, optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :category_id, dependent: :destroy
  has_many :custom_fields
  has_many :items

  accepts_nested_attributes_for :custom_fields

  scope :head_categories, -> { where(parent: nil) }

  def inherited_custom_fields_array
    custom_fields + (parent&.inherited_custom_fields_array || [])
  end

  def self.find_with_all_children(id)
    columns = column_names
    columns_joined = columns.join(',')
    sql =
      <<-SQL
        WITH RECURSIVE category_tree (#{columns_joined}, level)
        AS (
          SELECT
            #{columns_joined},
            0
          FROM categories
          WHERE id = #{id}

          UNION ALL
          SELECT
            #{columns.map { |col| 'cat.' + col }.join(',')},
            ct.level + 1
          FROM categories cat, category_tree ct
          WHERE cat.category_id = ct.id
        )
        SELECT * FROM category_tree
        WHERE level >= 0
        ORDER BY level, category_id, name;
      SQL
    sql.chomp

    find_by_sql(sql)
  end
end
