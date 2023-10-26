# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
4.times do
  Supplier.create(
    name: Faker::Company.name
  )
end

4.times do
  Category.create(
    name: Faker::Lorem.word
  )
end

100.times do
  product = Product.create(
    name: Faker::Food.dish,
    description: '...',
    price: Faker::Commerce.price,
    rating: Faker::Number.decimal(l_digits: 1, r_digits: 2),
    vegan: Faker::Boolean.boolean,
    sharing: Faker::Boolean.boolean,
    gluten_free: Faker::Boolean.boolean,
    sugar_free: Faker::Boolean.boolean,
    picada: Faker::Boolean.boolean,
  )

  product.supplier = Supplier.all.sample
  product.category = Category.all.sample
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/filipa_mini_box.png')), filename: 'filipa_mini_box.png')
  product.save
end
