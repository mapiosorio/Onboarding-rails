# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Product.destroy_all
Supplier.destroy_all


  Supplier.create(
    name: 'Filipa'
  )
  Supplier.create(
    name: 'La Petit Patisserie de Flor'
  )


5.times do
  product = Product.create(
    name: 'Mini Box Salada',
    description: '...',
    price: '495',
    rating: '4.95',
    vegan: true,
  )

  product.supplier = Supplier.find_by(name: 'Filipa')
  product.category = Category.find_by(name: 'Regalos')
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/filipa_mini_box.png')), filename: 'filipa_mini_box.png')
  product.save

  product = Product.create(
    name: 'Mini Box Dulce',
    description: '...',
    price: '150',
    rating: '4.85',
  )

  product.supplier = Supplier.find_by(name: 'Filipa')
  product.category = Category.find_by(name: 'Regalos')
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/filipa_mini_box_dulce.png')), filename: 'filipa_mini_box_dulce.png')
  product.save

  product = Product.create(
    name: 'Lunch Box',
    description: '...',
    price: '495',
    rating: '4.84',
  )

  product.supplier = Supplier.find_by(name: 'Filipa')
  product.category = Category.find_by(name: 'Regalos')
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/filipa_lunch_box.png')), filename: 'filipa_lunch_box.png')
  product.save

  product = Product.create(
    name: 'Desayuno Mini',
    description: '...',
    price: '800',
    rating: '4.70'
  )

  product.supplier = Supplier.find_by(name: 'La Petit Patisserie de Flor')
  product.category = Category.find_by(name: 'Regalos')
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/desayuno_mini.png')), filename: 'desayuno_mini.png')
  product.save

  product = Product.create(
    name: 'Mini Box Dulce',
    description: '...',
    price: '150',
    rating: '4.85',
  )

  product.supplier = Supplier.find_by(name: 'Filipa')
  product.category = Category.find_by(name: 'Regalos')
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/filipa_mini_box_dulce.png')), filename: 'filipa_mini_box_dulce.png')
  product.save
end

