class CustomFieldValue < ApplicationRecord
  belongs_to :item
  belongs_to :custom_field

  validates :custom_field, uniqueness: { scope: :item }
  validate :validate_value_format!

  private

  def validate_value_format!
    case custom_field.datatype
    when CustomField::STRING
      return # is string as default
    when CustomField::FLOAT
      return if is_num? value
      error_message = 'Must be a float number'
    end
    errors.add(:value, :format, message: error_message)
  end

  def is_num?(str)
    !!Float(str)
  rescue ArgumentError, TypeError
    false
  end
end
