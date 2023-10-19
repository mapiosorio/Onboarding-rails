class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :description
      t.string :name
      t.integer :price
      t.references :supplier, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
