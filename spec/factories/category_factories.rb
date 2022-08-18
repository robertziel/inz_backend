FactoryBot.define do
  factory :category do
    name { 'Name' }

    factory :category_with_custom_fields do
      after(:create) do |category|
        CustomField::DATATYPES.each do |datatype|
          create(:custom_field, datatype: datatype, category: category)
        end
      end
    end
  end
end
