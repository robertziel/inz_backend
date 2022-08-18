class Item < ApplicationRecord
  belongs_to :category
  has_many :custom_field_values, dependent: :destroy

  accepts_nested_attributes_for :custom_field_values

  validates :description, :price, :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  before_save :clean_custom_field_values

  private

  # callbacks

  def clean_custom_field_values
    custom_field_values.where.not(
      custom_field: category.inherited_custom_fields_array
    ).destroy_all
  end
end
