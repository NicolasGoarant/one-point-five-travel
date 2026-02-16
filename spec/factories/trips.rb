FactoryBot.define do
  factory :trip do
    user { nil }
    destination { nil }
    country { nil }
    transport_mode { nil }
    origin_city { "MyString" }
    origin_country_iso { "MyString" }
    origin_latitude { 1.5 }
    origin_longitude { 1.5 }
    distance_km { 1.5 }
    duration_days { 1 }
    travelers_count { 1 }
    departure_date { "2026-02-15" }
    return_date { "2026-02-15" }
    co2_transport_kg { 1.5 }
    co2_accommodation_kg { 1.5 }
    co2_total_kg { 1.5 }
    co2_per_day_kg { 1.5 }
    climate_country_score { 1.5 }
    transport_score { 1.5 }
    local_impact_score { 1.5 }
    overall_score { 1.5 }
    grade { "MyString" }
    recommendations { "MyText" }
    climate_weight_used { 1 }
    transport_weight_used { 1 }
    local_impact_weight_used { 1 }
    status { "MyString" }
  end
end
