class CreateCountries < ActiveRecord::Migration[7.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :name_fr
      t.string :iso_code, limit: 3
      t.string :slug
      t.string :continent
      t.string :region
      t.string :cat_rating
      t.string :cat_policies_rating
      t.string :cat_ndc_rating
      t.string :cat_fair_share_rating
      t.float :emissions_per_capita
      t.float :total_emissions_mt
      t.float :emissions_trend_pct
      t.integer :renewable_energy_pct
      t.float :ccpi_score
      t.integer :ccpi_rank
      t.float :climate_score
      t.float :local_impact_score
      t.float :biodiversity_score
      t.boolean :paris_agreement_signed
      t.boolean :paris_agreement_ratified
      t.date :paris_ratification_date
      t.text :ndc_summary
      t.float :tourism_gdp_pct
      t.integer :protected_areas_pct
      t.string :flag_emoji
      t.text :description
      t.text :description_fr
      t.string :capital
      t.float :latitude
      t.float :longitude
      t.date :data_last_updated

      t.timestamps
    end
  end
end
