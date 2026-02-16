class CreateDestinations < ActiveRecord::Migration[7.2]
  def change
    create_table :destinations do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.string :region
      t.text :description
      t.text :description_fr
      t.float :latitude
      t.float :longitude
      t.integer :green_accommodations_count
      t.integer :eco_certifications_count
      t.boolean :accessible_by_train
      t.string :nearest_train_station
      t.float :local_impact_score
      t.string :tourism_pressure
      t.integer :annual_visitors
      t.boolean :featured
      t.string :image_url

      t.timestamps
    end
  end
end
