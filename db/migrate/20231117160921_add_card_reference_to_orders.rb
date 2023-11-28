class AddCardReferenceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :card, foreign_key: true
  end
end
