FactoryBot.define do
  factory :transport_mode do
    name { "MyString" }
    name_fr { "MyString" }
    icon { "MyString" }
    co2_per_km { 1.5 }
    co2_per_km_short { 1.5 }
    co2_per_km_long { 1.5 }
    source { "MyString" }
    comfort_score { 1 }
    speed_score { 1 }
    active { false }
  end
end
