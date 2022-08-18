FactoryBot.define do
  factory :custom_field do
    name { 'Name' }
    datatype { CustomField::STRING }
    association :category
  end
end
