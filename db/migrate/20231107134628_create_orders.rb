class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :quantity, null: false, default: 0
      t.integer :total, null: false
      t.integer :subtotal, null: false
      t.integer :taxes, null: false
      t.boolean :surprise_delivery, default: false
      t.date :delivery_date, null: false
      t.time :delivery_time, null: false
      t.string :recipient_name, null: false
      t.string :recipient_phone_number, null: false
      t.bigint :rut, null: false
      t.string :company_name, null: false
      t.text :personalization_message
      t.string :delivery_direction, null: false
      t.boolean :re_delivery, default: false
      t.references :user, null: false
      t.references :product, null: false

      t.timestamps
    end
  end
end
