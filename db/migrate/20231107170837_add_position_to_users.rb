class AddPositionToUsers < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :user, :position, :string, null: false
    end
  end
end
