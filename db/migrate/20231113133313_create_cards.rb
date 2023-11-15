class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.bigint :number, null: false
      t.date :expiration_date, null: false
      t.string :cardholder, null: false
      t.integer :cvv, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
