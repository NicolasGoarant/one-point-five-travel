class CreateTransportModes < ActiveRecord::Migration[7.2]
  def change
    create_table :transport_modes do |t|
      t.string :name
      t.string :name_fr
      t.string :icon
      t.float :co2_per_km
      t.float :co2_per_km_short
      t.float :co2_per_km_long
      t.string :source
      t.integer :comfort_score
      t.integer :speed_score
      t.boolean :active

      t.timestamps
    end
  end
end
