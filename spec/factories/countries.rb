FactoryBot.define do
  factory :country do
    name { "MyString" }
    name_fr { "MyString" }
    iso_code { "MyString" }
    slug { "MyString" }
    continent { "MyString" }
    region { "MyString" }
    cat_rating { "MyString" }
    cat_policies_rating { "MyString" }
    cat_ndc_rating { "MyString" }
    cat_fair_share_rating { "MyString" }
    emissions_per_capita { 1.5 }
    total_emissions_mt { 1.5 }
    emissions_trend_pct { 1.5 }
    renewable_energy_pct { 1 }
    ccpi_score { 1.5 }
    ccpi_rank { 1 }
    climate_score { 1.5 }
    local_impact_score { 1.5 }
    biodiversity_score { 1.5 }
    paris_agreement_signed { false }
    paris_agreement_ratified { false }
    paris_ratification_date { "2026-02-15" }
    ndc_summary { "MyText" }
    tourism_gdp_pct { 1.5 }
    protected_areas_pct { 1 }
    flag_emoji { "MyString" }
    description { "MyText" }
    description_fr { "MyText" }
    capital { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    data_last_updated { "2026-02-15" }
  end
end
