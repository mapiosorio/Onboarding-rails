class AddDeliveryCostToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :delivery_cost, :integer, default: 0
  end
end
