FactoryBot.define do
  factory :destination do
    country { nil }
    name { "MyString" }
    slug { "MyString" }
    region { "MyString" }
    description { "MyText" }
    description_fr { "MyText" }
    latitude { 1.5 }
    longitude { 1.5 }
    green_accommodations_count { 1 }
    eco_certifications_count { 1 }
    accessible_by_train { false }
    nearest_train_station { "MyString" }
    local_impact_score { 1.5 }
    tourism_pressure { "MyString" }
    annual_visitors { 1 }
    featured { false }
    image_url { "MyString" }
  end
end
