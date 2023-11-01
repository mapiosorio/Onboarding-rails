FactoryBot.define do
  factory :user do
    company { Faker::Company.name}
    name { Faker::Name.name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    position { Faker::Company.profession }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
