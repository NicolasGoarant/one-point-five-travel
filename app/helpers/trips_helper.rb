module TripsHelper
  # Color for a pillar score (0-100)
  def pillar_color(score)
    case score
    when 80..100 then "#2D9D3A"
    when 60..79  then "#7BBF2A"
    when 40..59  then "#F5C542"
    when 20..39  then "#E8822A"
    else              "#C62828"
    end
  end

  # Human-readable CO₂ amount
  def format_co2(kg)
    if kg >= 1000
      "#{(kg / 1000.0).round(1)} t CO₂"
    else
      "#{kg.round(0)} kg CO₂"
    end
  end
end
