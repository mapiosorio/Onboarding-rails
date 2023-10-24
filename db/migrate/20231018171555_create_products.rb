class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :description
      t.string :name
      t.integer :price
      t.references :supplier, null: false
      t.references :category, null: false
      t.float :rating
      t.boolean :sharing
      t.boolean :vegan
      t.boolean :sugar_free
      t.boolean :gluten_free
      t.boolean :picada

      t.timestamps
    end
  end
end
