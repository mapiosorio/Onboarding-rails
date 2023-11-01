class CreateAdditionalsProductsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :additionals, :products
  end
end
