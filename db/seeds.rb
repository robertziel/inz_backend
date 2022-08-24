# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

emails = [
  'robert@gmail.co'
]

emails.each do |email|
  next if User.find_by_email(email)
  User.create(email: email, password: '12345678')
  puts "New user with email (#{email}) created!"
end

groceries = Category.find_or_create_by(name: 'Groceries')

# CARS

cars = Category.find_or_create_by(name: 'Cars')

petrol_cars = Category.find_or_create_by(name: 'Petrol', parent: cars)
electric_cars = Category.find_or_create_by(name: 'Electric', parent: cars)

tesla = Category.find_or_create_by(name: 'Tesla', parent: electric_cars)

opel = Category.find_or_create_by(name: 'Opel', parent: petrol_cars)
mercedes = Category.find_or_create_by(name: 'Mercedes', parent: petrol_cars)

# MOBILE PHONES

mobile_phones = Category.find_or_create_by(name: 'Mobile phones')

apple = Category.find_or_create_by(name: 'Apple', parent: mobile_phones)
iphone = Category.find_or_create_by(name: 'iPhone', parent: apple)

nokia = Category.find_or_create_by(name: 'Nokia', parent: mobile_phones)

# CUSTOM FIELDS

country = CustomField.find_or_create_by(name: 'Country', datatype: CustomField::STRING, category: groceries)
mileage = CustomField.find_or_create_by(name: 'Mileage', datatype: CustomField::FLOAT, category: cars)
year = CustomField.find_or_create_by(name: 'Year', datatype: CustomField::FLOAT, category: cars)
system = CustomField.find_or_create_by(name: 'System', datatype: CustomField::STRING, category: mobile_phones)

vectra = Item.find_or_create_by(name: 'Opel Vectra', price: 1333.63, description: 'Description', category: opel)
astra = Item.find_or_create_by(name: 'Opel Astra', price: 1633.63, description: 'Description', category: opel)
mercedes = Item.find_or_create_by(name: 'Mercedes Benz', price: 5633.63, description: 'Description', category: mercedes)

iphone_xr = Item.find_or_create_by(name: 'iphone XR', price: 633.63, description: 'Description', category: iphone)
iphone_7s = Item.find_or_create_by(name: 'iphone 7S', price: 233.63, description: 'Description', category: iphone)


CustomFieldValue.find_or_create_by(value: 'iOS 10', custom_field: system, item: iphone_xr)
CustomFieldValue.find_or_create_by(value: 'iOS 9', custom_field: system, item: iphone_7s)

CustomFieldValue.find_or_create_by(value: '1994', custom_field: year, item: vectra)
CustomFieldValue.find_or_create_by(value: '1997', custom_field: year, item: astra)
CustomFieldValue.find_or_create_by(value: '2013', custom_field: year, item: mercedes)

CustomFieldValue.find_or_create_by(value: '159394', custom_field: mileage, item: vectra)
CustomFieldValue.find_or_create_by(value: '51997', custom_field: mileage, item: astra)
CustomFieldValue.find_or_create_by(value: '32013', custom_field: mileage, item: mercedes)

AdminUser.create(email: 's15922@pjwstk.edu.pl', password: '12345678') unless AdminUser.any?
