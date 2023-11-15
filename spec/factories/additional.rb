FactoryBot.define do
  factory :additional do
    price { Faker::Commerce.price }
    description { Faker::Lorem.sentence(word_count: 10) }
    factory :additional_with_products do
      transient do
        products_count { 3 }
      end

      after(:create) do |additional, evaluator|
        create_list(:product, evaluator.products_count, additionals: [additional])
      end
    end
  end
end
