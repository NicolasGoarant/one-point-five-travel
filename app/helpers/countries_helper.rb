module CountriesHelper
  COUNTRY_PHOTOS = {
    "CRI" => "https://images.unsplash.com/photo-1580977276076-ae4b8c219b8e?w=800&h=400&fit=crop",
    "KEN" => "https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=800&h=400&fit=crop",
    "ETH" => "https://images.unsplash.com/photo-1523805009345-7448845a9e53?w=800&h=400&fit=crop",
    "MAR" => "https://images.unsplash.com/photo-1489749798305-4fea3ae63d43?w=800&h=400&fit=crop",
    "DNK" => "https://images.unsplash.com/photo-1513622470522-26c3c8a854bc?w=800&h=400&fit=crop",
    "NGA" => "https://images.unsplash.com/photo-1618828665011-0abd973f7bb8?w=800&h=400&fit=crop",
    "SWE" => "https://images.unsplash.com/photo-1509356843151-3e7d96241e11?w=800&h=400&fit=crop",
    "NOR" => "https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800&h=400&fit=crop",
    "DEU" => "https://images.unsplash.com/photo-1467269204594-9661b134dd2b?w=800&h=400&fit=crop",
    "GBR" => "https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=800&h=400&fit=crop",
    "IND" => "https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800&h=400&fit=crop",
    "PHL" => "https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=800&h=400&fit=crop",
    "PRT" => "https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=800&h=400&fit=crop",
    "CHL" => "https://images.unsplash.com/photo-1478827536114-da961b7f86d2?w=800&h=400&fit=crop",
    "NZL" => "https://images.unsplash.com/photo-1507699622108-4be3abd695ad?w=800&h=400&fit=crop",
    "FRA" => "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800&h=400&fit=crop",
    "JPN" => "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800&h=400&fit=crop",
    "BRA" => "https://images.unsplash.com/photo-1483729558449-99ef09a8c325?w=800&h=400&fit=crop",
    "ESP" => "https://images.unsplash.com/photo-1543783207-ec64e4d95325?w=800&h=400&fit=crop",
    "ITA" => "https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=800&h=400&fit=crop",
    "AUS" => "https://images.unsplash.com/photo-1523482580672-f109ba8cb9be?w=800&h=400&fit=crop",
    "CAN" => "https://images.unsplash.com/photo-1503614472-8c93d56e92ce?w=800&h=400&fit=crop",
    "USA" => "https://images.unsplash.com/photo-1485738422979-f5c462d49f04?w=800&h=400&fit=crop",
    "CHN" => "https://images.unsplash.com/photo-1547981609-4b6bfe67ca0b?w=800&h=400&fit=crop",
    "ZAF" => "https://images.unsplash.com/photo-1580060839134-75a5edca2e99?w=800&h=400&fit=crop",
    "THA" => "https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&h=400&fit=crop",
    "GRC" => "https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800&h=400&fit=crop",
    "ARG" => "https://images.unsplash.com/photo-1589909202802-8f4aadce1849?w=800&h=400&fit=crop",
    "IDN" => "https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800&h=400&fit=crop"
  }.freeze

  FALLBACK_PHOTO = "https://images.unsplash.com/photo-1488085061387-422e29b40080?w=800&h=400&fit=crop"

  def country_photo_url(country)
    COUNTRY_PHOTOS[country.iso_code] || FALLBACK_PHOTO
  end
end
