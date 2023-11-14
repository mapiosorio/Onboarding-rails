FactoryBot.define do
  factory :additional do
    price { Faker::Commerce.price }
    description { Faker::Lorem.sentence(word_count: 10) }
  end
end
