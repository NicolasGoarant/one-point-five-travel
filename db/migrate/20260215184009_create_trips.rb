class CreateTrips < ActiveRecord::Migration[7.2]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :transport_mode, null: false, foreign_key: true
      t.string :origin_city
      t.string :origin_country_iso, limit: 3
      t.float :origin_latitude
      t.float :origin_longitude
      t.float :distance_km
      t.integer :duration_days
      t.integer :travelers_count
      t.date :departure_date
      t.date :return_date
      t.float :co2_transport_kg
      t.float :co2_accommodation_kg
      t.float :co2_total_kg
      t.float :co2_per_day_kg
      t.float :climate_country_score
      t.float :transport_score
      t.float :local_impact_score
      t.float :overall_score
      t.string :grade
      t.text :recommendations
      t.integer :climate_weight_used
      t.integer :transport_weight_used
      t.integer :local_impact_weight_used
      t.string :status

      t.timestamps
    end
  end
end
