FactoryBot.define do
  factory :custom_field_value do
    value { '1' }

    association :custom_field
    association :item
  end
end
