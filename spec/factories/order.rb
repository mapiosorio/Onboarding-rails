FactoryBot.define do
  factory :order do
    quantity { Faker::Number.within(range: 1..10) }
    total { Faker::Number.between(from: 1000, to: 5000) }
    subtotal { Faker::Number.between(from: 800, to: 4500) }
    taxes { Faker::Number.between(from: 100, to: 500) }
    surprise_delivery { Faker::Boolean.boolean }
    delivery_date { Faker::Date.forward(days: 30) }
    delivery_time { Faker::Time.between(from: '08:00', to: '18:00') }
    recipient_name { Faker::Name.name }
    recipient_phone_number { Faker::PhoneNumber.phone_number }
    rut { Faker::Number.number(digits: 9) }
    company_name { Faker::Company.name }
    personalization_message { Faker::Lorem.sentence }
    delivery_direction { Faker::Address.full_address }
    re_delivery { Faker::Boolean.boolean }
    user
    product
    card
  end
end
