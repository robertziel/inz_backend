FactoryBot.define do
  factory :item do
    price { 1.5 }
    name { 'Name' }
    description { 'Description' }
    association :category
  end
end
