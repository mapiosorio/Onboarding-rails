class CreateAdditionals < ActiveRecord::Migration[7.0]
  def change
    create_table :additionals do |t|
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
