module Api
  class ItemSerializer < ApplicationSerializer
    include SerializersHelper

    attributes :id, :price, :name, :description, :custom_fields

    def custom_fields
      serialize_collection(object.custom_field_values, serializer: CustomFieldValueSerializer)
    end
  end
end
