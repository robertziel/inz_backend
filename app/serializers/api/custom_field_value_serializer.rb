module Api
  class CustomFieldValueSerializer < ApplicationSerializer
    attributes :value, :name

    def name
      object.custom_field.name
    end
  end
end
