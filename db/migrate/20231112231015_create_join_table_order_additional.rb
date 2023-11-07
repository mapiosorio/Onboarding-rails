class CreateJoinTableOrderAdditional < ActiveRecord::Migration[7.0]
  def change
    create_join_table :orders, :additionals do |t|
      # t.index [:order_id, :additional_id]
      # t.index [:additional_id, :order_id]
    end
  end
end
