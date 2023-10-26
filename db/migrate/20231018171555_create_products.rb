class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :description
      t.string :name
      t.integer :price
      t.references :supplier, null: false
      t.references :category, null: false
      t.float :rating
      t.boolean :sharing, default: false
      t.boolean :vegan, default: false
      t.boolean :sugar_free, default: false
      t.boolean :gluten_free, default: false
      t.boolean :picada, default: false

      t.timestamps
    end
  end
end
