# app/services/trip_scoring_service.rb
#
# The core scoring engine of 1.5° Travel.
# Calculates a trip's overall sustainability score based on three pillars:
#
#   1. Climate Country Score (Pilier Climat Pays)
#      -> How aligned is the destination country with the Paris Agreement?
#
#   2. Transport Score (Pilier Empreinte Trajet)
#      -> How much CO2 does the journey emit?
#
#   3. Local Impact Score (Pilier Impact Local)
#      -> Does tourism benefit or harm local communities?
#
# Each pillar is scored 0-100, then weighted according to user preferences.
# The aggregate produces a grade A-E (inspired by Nutri-Score).
#
class TripScoringService
  # Annual CO2 budget per person for travel, aligned with 1.5°C pathway
  # Source: ~2 tonnes total annual budget, 30% allocated to travel
  ANNUAL_TRAVEL_CO2_BUDGET_KG = 600

  # Reference distances for transport scoring
  EXCELLENT_CO2_PER_DAY = 5    # kg CO2/day - train travel in Europe
  TERRIBLE_CO2_PER_DAY  = 200  # kg CO2/day - long-haul flight, short stay

  def initialize(trip)
    @trip = trip
    @country = trip.country
    @transport = trip.transport_mode
    @user = trip.user
  end

  def call
    climate_score   = calculate_climate_score
    transport_score = calculate_transport_score
    local_score     = calculate_local_impact_score
    overall         = calculate_overall_score(climate_score, transport_score, local_score)
    grade           = score_to_grade(overall)
    recommendations = generate_recommendations(climate_score, transport_score, local_score)

    {
      climate_country_score: climate_score,
      transport_score:       transport_score,
      local_impact_score:    local_score,
      overall_score:         overall,
      grade:                 grade,
      recommendations:       recommendations.to_json,
      climate_weight_used:   weights[:climate],
      transport_weight_used: weights[:transport],
      local_impact_weight_used: weights[:local_impact],
      co2_transport_kg:      co2_transport,
      co2_accommodation_kg:  co2_accommodation,
      co2_total_kg:          co2_transport + co2_accommodation,
      co2_per_day_kg:        co2_per_day
    }
  end

  private

  # --- PILLAR 1: CLIMATE COUNTRY SCORE ---

  def calculate_climate_score
    return 0 unless @country
    @country.climate_score || 0
  end

  # --- PILLAR 2: TRANSPORT SCORE ---

  def calculate_transport_score
    return 50 unless @transport && @trip.distance_km&.positive?

    daily_co2 = co2_per_day

    if daily_co2 <= EXCELLENT_CO2_PER_DAY
      100.0
    elsif daily_co2 >= TERRIBLE_CO2_PER_DAY
      0.0
    else
      log_min = Math.log(EXCELLENT_CO2_PER_DAY)
      log_max = Math.log(TERRIBLE_CO2_PER_DAY)
      log_val = Math.log(daily_co2)
      (100.0 * (1 - (log_val - log_min) / (log_max - log_min))).round(1)
    end
  end

  # --- PILLAR 3: LOCAL IMPACT SCORE ---

  def calculate_local_impact_score
    scores = []

    if @country&.tourism_gdp_pct
      tourism_score = case @country.tourism_gdp_pct
                      when 0..2    then 30
                      when 2..5    then 60
                      when 5..15   then 90
                      when 15..30  then 60
                      else              30
                      end
      scores << tourism_score
    end

    if @country&.protected_areas_pct
      scores << [@country.protected_areas_pct.to_f * 3, 100].min
    end

    if @trip.destination
      dest = @trip.destination

      pressure_score = case dest.tourism_pressure
                       when "low"         then 100
                       when "moderate"    then 75
                       when "high"        then 40
                       when "overtourism" then 10
                       else                    60
                       end
      scores << pressure_score

      scores << (dest.accessible_by_train ? 80 : 50)

      if dest.eco_certifications_count&.positive?
        scores << [dest.eco_certifications_count * 20, 100].min
      end
    end

    return 50 if scores.empty?
    (scores.sum.to_f / scores.size).round(1)
  end

  # --- OVERALL SCORE & GRADE ---

  def calculate_overall_score(climate, transport, local)
    w = weights
    (
      climate   * w[:climate]      / 100.0 +
      transport * w[:transport]    / 100.0 +
      local     * w[:local_impact] / 100.0
    ).round(1)
  end

  def score_to_grade(score)
    case score
    when 80..100 then "A"
    when 60..79  then "B"
    when 40..59  then "C"
    when 20..39  then "D"
    else              "E"
    end
  end

  def weights
    @weights ||= if @user&.respond_to?(:scoring_weights) && @user.scoring_weights.present?
                   @user.scoring_weights
                 else
                   { climate: 30, transport: 40, local_impact: 30 }
                 end
  end

  # --- CO2 CALCULATIONS ---

  def co2_transport
    @co2_transport ||= if @transport && @trip.distance_km&.positive?
                          @transport.co2_per_km * @trip.distance_km * 2
                        else
                          0
                        end
  end

  def co2_accommodation
    @co2_accommodation ||= begin
      nights = (@trip.duration_days || 1)
      base_rate = @trip.destination&.eco_certifications_count&.positive? ? 8 : 20
      nights * base_rate
    end
  end

  def co2_per_day
    @co2_per_day ||= begin
      total = co2_transport + co2_accommodation
      days = [@trip.duration_days || 1, 1].max
      (total / days).round(1)
    end
  end

  # --- RECOMMENDATIONS ---

  def generate_recommendations(climate_score, transport_score, local_score)
    tips = []

    if transport_score < 50 && @transport&.name == "plane"
      if @trip.distance_km && @trip.distance_km < 800
        tips << {
          type: "transport",
          priority: "high",
          message: "Ce trajet fait moins de 800 km — le train serait beaucoup plus écologique.",
          potential_improvement: "+30 points sur le pilier transport"
        }
      end

      tips << {
        type: "transport",
        priority: "medium",
        message: "Un séjour plus long réduirait l'impact quotidien du vol.",
        potential_improvement: "+#{((co2_transport / ((@trip.duration_days || 1) + 3)) - co2_per_day).abs.round(0)} kg CO2/jour en restant 3 jours de plus"
      }
    end

    if climate_score < 40
      tips << {
        type: "climate",
        priority: "medium",
        message: "#{@country&.name_fr} a un faible score climatique. Compensez en choisissant des prestataires locaux certifiés.",
        potential_improvement: "Impact indirect positif"
      }
    end

    if local_score < 50 && @trip.destination&.tourism_pressure == "overtourism"
      tips << {
        type: "local_impact",
        priority: "high",
        message: "Cette destination souffre de surtourisme. Envisagez une période hors-saison ou une destination alternative.",
        potential_improvement: "+20 points sur le pilier impact local"
      }
    end

    if (@trip.duration_days || 0) < 4 && @transport&.name == "plane"
      tips << {
        type: "duration",
        priority: "medium",
        message: "Un voyage de moins de 4 jours en avion a un ratio CO2/jour très défavorable.",
        potential_improvement: "Doublez la durée pour diviser l'impact quotidien par deux"
      }
    end

    tips
  end
end
