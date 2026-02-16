# app/services/distance_calculator.rb
#
# Calculates the great-circle distance between two geographic points
# using the Haversine formula.
#
class DistanceCalculator
  EARTH_RADIUS_KM = 6371.0

  # Returns distance in kilometers between two lat/lng pairs
  def self.haversine(lat1, lon1, lat2, lon2)
    lat1_rad = to_radians(lat1)
    lat2_rad = to_radians(lat2)
    delta_lat = to_radians(lat2 - lat1)
    delta_lon = to_radians(lon2 - lon1)

    a = Math.sin(delta_lat / 2)**2 +
        Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(delta_lon / 2)**2

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    (EARTH_RADIUS_KM * c).round(1)
  end

  def self.to_radians(degrees)
    degrees * Math::PI / 180
  end
end
