FactoryBot.define do
  factory :card do
    number { Faker::Number.number(digits: 16) }
    expiration_date { Faker::Date.between(from: Date.today, to: 10.years.from_now) }
    cardholder { Faker::Name.name }
    cvv { Faker::Number.number(digits: 3) }
    user
  end
end
