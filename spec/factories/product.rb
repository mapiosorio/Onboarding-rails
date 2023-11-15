FactoryBot.define do
  factory :product do
    description { Faker::Food.description }
    name { Faker::Food.dish }
    price { Faker::Commerce.price }
    provider { association(:provider) }
    category { association(:category) }
    vegan { Faker::Boolean.boolean }
    sharing { Faker::Boolean.boolean }
    gluten_free { Faker::Boolean.boolean }
    sugar_free { Faker::Boolean.boolean }
    finger_food { Faker::Boolean.boolean }
    rating { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    factory :product_with_additionals do
      transient do
        additionals_count { 3 }
      end

      after(:create) do |product, evaluator|
        create_list(:additional, evaluator.additionals_count, products: [product])
      end
    end
  end
end
