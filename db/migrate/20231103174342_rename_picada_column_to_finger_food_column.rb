class RenamePicadaColumnToFingerFoodColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :picada, :finger_food
  end
end
