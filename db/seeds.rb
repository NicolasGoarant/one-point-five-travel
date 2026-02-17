# db/seeds.rb
#
# Seeds the database with:
# 1. Transport modes (ADEME emission factors)
# 2. Countries with real Climate Action Tracker data
# 3. Sample destinations
#
# Sources:
# - Climate Action Tracker (climateactiontracker.org) — CAT ratings
# - Germanwatch CCPI 2024
# - Global Carbon Project — emissions per capita
# - ADEME Base Empreinte — transport emission factors
# - World Bank / WTTC — tourism GDP data

puts "🌍 Seeding 1.5° Travel database..."

# ─── TRANSPORT MODES ──────────────────────────────────────────────────
# Source: ADEME Base Empreinte (2023) — kg CO2eq per passenger-km
puts "🚂 Creating transport modes..."

transport_data = [
  {
    name: "train",      name_fr: "Train",          icon: "🚂",
    co2_per_km: 0.006,  co2_per_km_short: 0.006,   co2_per_km_long: 0.006,
    source: "ADEME 2023", comfort_score: 80, speed_score: 60
  },
  {
    name: "bus",         name_fr: "Bus / Car",      icon: "🚌",
    co2_per_km: 0.030,  co2_per_km_short: 0.035,   co2_per_km_long: 0.025,
    source: "ADEME 2023", comfort_score: 40, speed_score: 40
  },
  {
    name: "car_shared",  name_fr: "Voiture (covoiturage)", icon: "🚗",
    co2_per_km: 0.055,  co2_per_km_short: 0.065,   co2_per_km_long: 0.050,
    source: "ADEME 2023 — 2.5 occupants", comfort_score: 70, speed_score: 65
  },
  {
    name: "car_solo",    name_fr: "Voiture (solo)", icon: "🚘",
    co2_per_km: 0.110,  co2_per_km_short: 0.130,   co2_per_km_long: 0.100,
    source: "ADEME 2023 — voiture thermique moyenne", comfort_score: 75, speed_score: 70
  },
  {
    name: "car_electric", name_fr: "Voiture électrique", icon: "⚡",
    co2_per_km: 0.020,  co2_per_km_short: 0.025,   co2_per_km_long: 0.019,
    source: "ADEME 2023 — mix FR", comfort_score: 75, speed_score: 70
  },
  {
    name: "ferry",       name_fr: "Ferry",          icon: "⛴️",
    co2_per_km: 0.090,  co2_per_km_short: 0.115,   co2_per_km_long: 0.080,
    source: "ADEME 2023", comfort_score: 60, speed_score: 20
  },
  {
    name: "plane_short", name_fr: "Avion (< 1500 km)", icon: "✈️",
    co2_per_km: 0.230,  co2_per_km_short: 0.258,   co2_per_km_long: 0.230,
    source: "ADEME 2023 — court-courrier", comfort_score: 50, speed_score: 95
  },
  {
    name: "plane_long",  name_fr: "Avion (> 1500 km)", icon: "🛫",
    co2_per_km: 0.152,  co2_per_km_short: 0.187,   co2_per_km_long: 0.152,
    source: "ADEME 2023 — long-courrier", comfort_score: 45, speed_score: 100
  },
  {
    name: "bicycle",     name_fr: "Vélo",           icon: "🚲",
    co2_per_km: 0.0,    co2_per_km_short: 0.0,     co2_per_km_long: 0.0,
    source: "Zéro émission directe", comfort_score: 30, speed_score: 10
  }
]

transport_data.each do |data|
  TransportMode.find_or_create_by!(name: data[:name]) do |tm|
    tm.assign_attributes(data)
  end
end

puts "  ✅ #{TransportMode.count} modes de transport créés"

# ─── COUNTRIES ────────────────────────────────────────────────────────
# Source: Climate Action Tracker (2024), Germanwatch CCPI 2024,
#         Global Carbon Project 2023, World Bank
puts "🌍 Creating countries with climate data..."

countries_data = [
  # ── 1.5°C COMPATIBLE ──
  {
    name: "Morocco", name_fr: "Maroc", iso_code: "MAR", continent: "Afrique",
    flag_emoji: "🇲🇦", capital: "Rabat", latitude: 31.79, longitude: -7.09,
    cat_rating: "1.5c_compatible", ccpi_score: 78.0, ccpi_rank: 4,
    emissions_per_capita: 1.8, total_emissions_mt: 66.0, emissions_trend_pct: 2.0,
    renewable_energy_pct: 20, tourism_gdp_pct: 7.0, protected_areas_pct: 26,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Costa Rica", name_fr: "Costa Rica", iso_code: "CRI", continent: "Amérique_du_Nord",
    flag_emoji: "🇨🇷", capital: "San José", latitude: 9.93, longitude: -84.09,
    cat_rating: "1.5c_compatible", ccpi_score: 70.0, ccpi_rank: 10,
    emissions_per_capita: 1.5, total_emissions_mt: 8.0, emissions_trend_pct: -1.0,
    renewable_energy_pct: 99, tourism_gdp_pct: 8.0, protected_areas_pct: 28,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-13"
  },
  {
    name: "Kenya", name_fr: "Kenya", iso_code: "KEN", continent: "Afrique",
    flag_emoji: "🇰🇪", capital: "Nairobi", latitude: -1.29, longitude: 36.82,
    cat_rating: "1.5c_compatible", ccpi_score: 65.0, ccpi_rank: 15,
    emissions_per_capita: 0.4, total_emissions_mt: 22.0, emissions_trend_pct: 1.5,
    renewable_energy_pct: 90, tourism_gdp_pct: 5.0, protected_areas_pct: 12,
    paris_agreement_ratified: true, paris_ratification_date: "2016-12-28"
  },
  {
    name: "Ethiopia", name_fr: "Éthiopie", iso_code: "ETH", continent: "Afrique",
    flag_emoji: "🇪🇹", capital: "Addis-Abeba", latitude: 9.02, longitude: 38.75,
    cat_rating: "1.5c_compatible", ccpi_score: 62.0, ccpi_rank: 18,
    emissions_per_capita: 0.2, total_emissions_mt: 24.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 96, tourism_gdp_pct: 3.5, protected_areas_pct: 18,
    paris_agreement_ratified: true, paris_ratification_date: "2017-03-09"
  },
  {
    name: "Nigeria", name_fr: "Nigeria", iso_code: "NGA", continent: "Afrique",
    flag_emoji: "🇳🇬", capital: "Abuja", latitude: 9.08, longitude: 7.49,
    cat_rating: "1.5c_compatible", ccpi_score: 58.0, ccpi_rank: 22,
    emissions_per_capita: 0.6, total_emissions_mt: 130.0, emissions_trend_pct: 1.0,
    renewable_energy_pct: 19, tourism_gdp_pct: 1.5, protected_areas_pct: 14,
    paris_agreement_ratified: true, paris_ratification_date: "2017-05-16"
  },

  # ── ALMOST SUFFICIENT ──
  {
    name: "Denmark", name_fr: "Danemark", iso_code: "DNK", continent: "Europe",
    flag_emoji: "🇩🇰", capital: "Copenhague", latitude: 55.68, longitude: 12.57,
    cat_rating: "almost_sufficient", ccpi_score: 79.6, ccpi_rank: 2,
    emissions_per_capita: 5.1, total_emissions_mt: 30.0, emissions_trend_pct: -8.0,
    renewable_energy_pct: 80, tourism_gdp_pct: 3.5, protected_areas_pct: 15,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-01"
  },
  {
    name: "Norway", name_fr: "Norvège", iso_code: "NOR", continent: "Europe",
    flag_emoji: "🇳🇴", capital: "Oslo", latitude: 59.91, longitude: 10.75,
    cat_rating: "almost_sufficient", ccpi_score: 66.0, ccpi_rank: 12,
    emissions_per_capita: 7.5, total_emissions_mt: 41.0, emissions_trend_pct: -4.0,
    renewable_energy_pct: 98, tourism_gdp_pct: 4.0, protected_areas_pct: 17,
    paris_agreement_ratified: true, paris_ratification_date: "2016-06-20"
  },
  {
    name: "United Kingdom", name_fr: "Royaume-Uni", iso_code: "GBR", continent: "Europe",
    flag_emoji: "🇬🇧", capital: "Londres", latitude: 51.51, longitude: -0.13,
    cat_rating: "almost_sufficient", ccpi_score: 63.0, ccpi_rank: 16,
    emissions_per_capita: 4.7, total_emissions_mt: 310.0, emissions_trend_pct: -5.0,
    renewable_energy_pct: 43, tourism_gdp_pct: 3.8, protected_areas_pct: 28,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-18"
  },
  {
    name: "Netherlands", name_fr: "Pays-Bas", iso_code: "NLD", continent: "Europe",
    flag_emoji: "🇳🇱", capital: "Amsterdam", latitude: 52.37, longitude: 4.90,
    cat_rating: "almost_sufficient", ccpi_score: 61.0, ccpi_rank: 19,
    emissions_per_capita: 8.3, total_emissions_mt: 145.0, emissions_trend_pct: -3.0,
    renewable_energy_pct: 15, tourism_gdp_pct: 4.2, protected_areas_pct: 21,
    paris_agreement_ratified: true, paris_ratification_date: "2016-07-28"
  },
  {
    name: "Germany", name_fr: "Allemagne", iso_code: "DEU", continent: "Europe",
    flag_emoji: "🇩🇪", capital: "Berlin", latitude: 52.52, longitude: 13.41,
    cat_rating: "almost_sufficient", ccpi_score: 63.5, ccpi_rank: 14,
    emissions_per_capita: 8.1, total_emissions_mt: 674.0, emissions_trend_pct: -6.0,
    renewable_energy_pct: 46, tourism_gdp_pct: 3.9, protected_areas_pct: 38,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Nepal", name_fr: "Népal", iso_code: "NPL", continent: "Asie",
    flag_emoji: "🇳🇵", capital: "Katmandou", latitude: 27.72, longitude: 85.32,
    cat_rating: "almost_sufficient", ccpi_score: 55.0, ccpi_rank: 25,
    emissions_per_capita: 0.5, total_emissions_mt: 15.0, emissions_trend_pct: 2.0,
    renewable_energy_pct: 85, tourism_gdp_pct: 3.0, protected_areas_pct: 23,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },

  # ── INSUFFICIENT ──
  {
    name: "France", name_fr: "France", iso_code: "FRA", continent: "Europe",
    flag_emoji: "🇫🇷", capital: "Paris", latitude: 48.86, longitude: 2.35,
    cat_rating: "insufficient", ccpi_score: 57.9, ccpi_rank: 23,
    emissions_per_capita: 4.7, total_emissions_mt: 306.0, emissions_trend_pct: -3.0,
    renewable_energy_pct: 21, tourism_gdp_pct: 8.5, protected_areas_pct: 32,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Japan", name_fr: "Japon", iso_code: "JPN", continent: "Asie",
    flag_emoji: "🇯🇵", capital: "Tokyo", latitude: 35.68, longitude: 139.69,
    cat_rating: "insufficient", ccpi_score: 45.0, ccpi_rank: 40,
    emissions_per_capita: 8.5, total_emissions_mt: 1067.0, emissions_trend_pct: -2.0,
    renewable_energy_pct: 22, tourism_gdp_pct: 2.5, protected_areas_pct: 21,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-08"
  },
  {
    name: "Brazil", name_fr: "Brésil", iso_code: "BRA", continent: "Amérique_du_Sud",
    flag_emoji: "🇧🇷", capital: "Brasília", latitude: -15.79, longitude: -47.88,
    cat_rating: "insufficient", ccpi_score: 50.0, ccpi_rank: 35,
    emissions_per_capita: 2.3, total_emissions_mt: 490.0, emissions_trend_pct: 4.0,
    renewable_energy_pct: 45, tourism_gdp_pct: 2.2, protected_areas_pct: 30,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Mexico", name_fr: "Mexique", iso_code: "MEX", continent: "Amérique_du_Nord",
    flag_emoji: "🇲🇽", capital: "Mexico", latitude: 19.43, longitude: -99.13,
    cat_rating: "insufficient", ccpi_score: 47.0, ccpi_rank: 38,
    emissions_per_capita: 3.6, total_emissions_mt: 467.0, emissions_trend_pct: 1.0,
    renewable_energy_pct: 16, tourism_gdp_pct: 8.7, protected_areas_pct: 14,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Spain", name_fr: "Espagne", iso_code: "ESP", continent: "Europe",
    flag_emoji: "🇪🇸", capital: "Madrid", latitude: 40.42, longitude: -3.70,
    cat_rating: "insufficient", ccpi_score: 53.0, ccpi_rank: 30,
    emissions_per_capita: 5.2, total_emissions_mt: 248.0, emissions_trend_pct: -2.0,
    renewable_energy_pct: 22, tourism_gdp_pct: 12.4, protected_areas_pct: 28,
    paris_agreement_ratified: true, paris_ratification_date: "2017-01-12"
  },
  {
    name: "Italy", name_fr: "Italie", iso_code: "ITA", continent: "Europe",
    flag_emoji: "🇮🇹", capital: "Rome", latitude: 41.90, longitude: 12.50,
    cat_rating: "insufficient", ccpi_score: 52.0, ccpi_rank: 32,
    emissions_per_capita: 5.5, total_emissions_mt: 326.0, emissions_trend_pct: -2.5,
    renewable_energy_pct: 20, tourism_gdp_pct: 13.0, protected_areas_pct: 22,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-11"
  },
  {
    name: "Portugal", name_fr: "Portugal", iso_code: "PRT", continent: "Europe",
    flag_emoji: "🇵🇹", capital: "Lisbonne", latitude: 38.72, longitude: -9.14,
    cat_rating: "insufficient", ccpi_score: 60.0, ccpi_rank: 20,
    emissions_per_capita: 4.3, total_emissions_mt: 44.0, emissions_trend_pct: -4.0,
    renewable_energy_pct: 34, tourism_gdp_pct: 17.0, protected_areas_pct: 22,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Greece", name_fr: "Grèce", iso_code: "GRC", continent: "Europe",
    flag_emoji: "🇬🇷", capital: "Athènes", latitude: 37.98, longitude: 23.73,
    cat_rating: "insufficient", ccpi_score: 48.0, ccpi_rank: 37,
    emissions_per_capita: 5.7, total_emissions_mt: 60.0, emissions_trend_pct: -3.0,
    renewable_energy_pct: 22, tourism_gdp_pct: 20.0, protected_areas_pct: 35,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-14"
  },

  # ── HIGHLY INSUFFICIENT ──
  {
    name: "United States", name_fr: "États-Unis", iso_code: "USA", continent: "Amérique_du_Nord",
    flag_emoji: "🇺🇸", capital: "Washington", latitude: 38.91, longitude: -77.04,
    cat_rating: "highly_insufficient", ccpi_score: 44.0, ccpi_rank: 43,
    emissions_per_capita: 14.4, total_emissions_mt: 4850.0, emissions_trend_pct: -1.0,
    renewable_energy_pct: 22, tourism_gdp_pct: 2.9, protected_areas_pct: 13,
    paris_agreement_signed: true, paris_agreement_ratified: false
  },
  {
    name: "China", name_fr: "Chine", iso_code: "CHN", continent: "Asie",
    flag_emoji: "🇨🇳", capital: "Pékin", latitude: 39.91, longitude: 116.40,
    cat_rating: "highly_insufficient", ccpi_score: 51.0, ccpi_rank: 33,
    emissions_per_capita: 8.9, total_emissions_mt: 12600.0, emissions_trend_pct: 0.5,
    renewable_energy_pct: 30, tourism_gdp_pct: 5.0, protected_areas_pct: 15,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-03"
  },
  {
    name: "Canada", name_fr: "Canada", iso_code: "CAN", continent: "Amérique_du_Nord",
    flag_emoji: "🇨🇦", capital: "Ottawa", latitude: 45.42, longitude: -75.70,
    cat_rating: "highly_insufficient", ccpi_score: 40.0, ccpi_rank: 50,
    emissions_per_capita: 14.2, total_emissions_mt: 546.0, emissions_trend_pct: -1.5,
    renewable_energy_pct: 68, tourism_gdp_pct: 2.0, protected_areas_pct: 13,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Australia", name_fr: "Australie", iso_code: "AUS", continent: "Océanie",
    flag_emoji: "🇦🇺", capital: "Canberra", latitude: -35.28, longitude: 149.13,
    cat_rating: "highly_insufficient", ccpi_score: 37.0, ccpi_rank: 55,
    emissions_per_capita: 15.0, total_emissions_mt: 396.0, emissions_trend_pct: 0.0,
    renewable_energy_pct: 32, tourism_gdp_pct: 3.1, protected_areas_pct: 20,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-09"
  },
  {
    name: "Thailand", name_fr: "Thaïlande", iso_code: "THA", continent: "Asie",
    flag_emoji: "🇹🇭", capital: "Bangkok", latitude: 13.76, longitude: 100.50,
    cat_rating: "highly_insufficient", ccpi_score: 41.0, ccpi_rank: 48,
    emissions_per_capita: 3.8, total_emissions_mt: 266.0, emissions_trend_pct: 1.5,
    renewable_energy_pct: 12, tourism_gdp_pct: 18.0, protected_areas_pct: 19,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Turkey", name_fr: "Turquie", iso_code: "TUR", continent: "Europe",
    flag_emoji: "🇹🇷", capital: "Ankara", latitude: 39.93, longitude: 32.85,
    cat_rating: "highly_insufficient", ccpi_score: 42.0, ccpi_rank: 47,
    emissions_per_capita: 5.1, total_emissions_mt: 434.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 42, tourism_gdp_pct: 12.0, protected_areas_pct: 5,
    paris_agreement_ratified: true, paris_ratification_date: "2021-10-07"
  },
  {
    name: "India", name_fr: "Inde", iso_code: "IND", continent: "Asie",
    flag_emoji: "🇮🇳", capital: "New Delhi", latitude: 28.61, longitude: 77.21,
    cat_rating: "highly_insufficient", ccpi_score: 60.5, ccpi_rank: 7,
    emissions_per_capita: 2.0, total_emissions_mt: 2830.0, emissions_trend_pct: 4.0,
    renewable_energy_pct: 20, tourism_gdp_pct: 5.0, protected_areas_pct: 6,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-02"
  },

  # ── CRITICALLY INSUFFICIENT ──
  {
    name: "Russia", name_fr: "Russie", iso_code: "RUS", continent: "Europe",
    flag_emoji: "🇷🇺", capital: "Moscou", latitude: 55.76, longitude: 37.62,
    cat_rating: "critically_insufficient", ccpi_score: 28.0, ccpi_rank: 60,
    emissions_per_capita: 12.0, total_emissions_mt: 1750.0, emissions_trend_pct: 1.0,
    renewable_energy_pct: 20, tourism_gdp_pct: 1.5, protected_areas_pct: 13,
    paris_agreement_ratified: true, paris_ratification_date: "2019-09-23"
  },
  {
    name: "Saudi Arabia", name_fr: "Arabie Saoudite", iso_code: "SAU", continent: "Asie",
    flag_emoji: "🇸🇦", capital: "Riyad", latitude: 24.77, longitude: 46.74,
    cat_rating: "critically_insufficient", ccpi_score: 18.0, ccpi_rank: 67,
    emissions_per_capita: 18.7, total_emissions_mt: 672.0, emissions_trend_pct: 2.0,
    renewable_energy_pct: 1, tourism_gdp_pct: 3.5, protected_areas_pct: 6,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-03"
  },
  {
    name: "United Arab Emirates", name_fr: "Émirats Arabes Unis", iso_code: "ARE", continent: "Asie",
    flag_emoji: "🇦🇪", capital: "Abou Dabi", latitude: 24.45, longitude: 54.65,
    cat_rating: "critically_insufficient", ccpi_score: 22.0, ccpi_rank: 65,
    emissions_per_capita: 21.8, total_emissions_mt: 216.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 7, tourism_gdp_pct: 12.0, protected_areas_pct: 16,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  }
]



# ─── ADDITIONAL COUNTRIES ─────────────────────────────────────────────
# Ajouter ce bloc dans db/seeds.rb APRÈS le tableau countries_data existant,
# AVANT la boucle `countries_data.each do |data|`
#
# Sources :
# - Climate Action Tracker (2024) — climateactiontracker.org
# - Germanwatch CCPI 2024
# - Global Carbon Project 2023 — emissions per capita
# - World Bank — tourism GDP, protected areas
# - IEA — renewable energy mix
#
# Pour ajouter ces pays : coller ce contenu à la suite du tableau countries_data
# existant (avant le `]` de fermeture du tableau), puis relancer `rails db:seed`

additional_countries = [

  # ══════════════════════════════════════════════
  # ALMOST SUFFICIENT
  # ══════════════════════════════════════════════

  {
    name: "Sweden", name_fr: "Suède", iso_code: "SWE", continent: "Europe",
    flag_emoji: "🇸🇪", capital: "Stockholm", latitude: 59.33, longitude: 18.07,
    cat_rating: "almost_sufficient", ccpi_score: 74.0, ccpi_rank: 6,
    emissions_per_capita: 3.6, total_emissions_mt: 38.0, emissions_trend_pct: -7.0,
    renewable_energy_pct: 60, tourism_gdp_pct: 2.8, protected_areas_pct: 15,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-13"
  },
  {
    name: "Chile", name_fr: "Chili", iso_code: "CHL", continent: "Amérique_du_Sud",
    flag_emoji: "🇨🇱", capital: "Santiago", latitude: -33.45, longitude: -70.67,
    cat_rating: "almost_sufficient", ccpi_score: 67.0, ccpi_rank: 11,
    emissions_per_capita: 4.7, total_emissions_mt: 91.0, emissions_trend_pct: -2.0,
    renewable_energy_pct: 32, tourism_gdp_pct: 3.2, protected_areas_pct: 21,
    paris_agreement_ratified: true, paris_ratification_date: "2017-02-10"
  },
  {
    name: "Finland", name_fr: "Finlande", iso_code: "FIN", continent: "Europe",
    flag_emoji: "🇫🇮", capital: "Helsinki", latitude: 60.17, longitude: 24.94,
    cat_rating: "almost_sufficient", ccpi_score: 64.0, ccpi_rank: 13,
    emissions_per_capita: 6.8, total_emissions_mt: 38.0, emissions_trend_pct: -6.0,
    renewable_energy_pct: 44, tourism_gdp_pct: 2.6, protected_areas_pct: 15,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-14"
  },
  {
    name: "Philippines", name_fr: "Philippines", iso_code: "PHL", continent: "Asie",
    flag_emoji: "🇵🇭", capital: "Manille", latitude: 14.60, longitude: 120.98,
    cat_rating: "almost_sufficient", ccpi_score: 59.0, ccpi_rank: 21,
    emissions_per_capita: 1.3, total_emissions_mt: 148.0, emissions_trend_pct: 4.0,
    renewable_energy_pct: 22, tourism_gdp_pct: 5.5, protected_areas_pct: 11,
    paris_agreement_ratified: true, paris_ratification_date: "2017-03-23"
  },

  # ══════════════════════════════════════════════
  # INSUFFICIENT
  # ══════════════════════════════════════════════

  {
    name: "New Zealand", name_fr: "Nouvelle-Zélande", iso_code: "NZL", continent: "Océanie",
    flag_emoji: "🇳🇿", capital: "Wellington", latitude: -41.29, longitude: 174.78,
    cat_rating: "insufficient", ccpi_score: 52.0, ccpi_rank: 31,
    emissions_per_capita: 6.2, total_emissions_mt: 32.0, emissions_trend_pct: -3.0,
    renewable_energy_pct: 40, tourism_gdp_pct: 5.8, protected_areas_pct: 32,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-04"
  },
  {
    name: "Switzerland", name_fr: "Suisse", iso_code: "CHE", continent: "Europe",
    flag_emoji: "🇨🇭", capital: "Berne", latitude: 46.95, longitude: 7.45,
    cat_rating: "insufficient", ccpi_score: 55.0, ccpi_rank: 24,
    emissions_per_capita: 4.0, total_emissions_mt: 35.0, emissions_trend_pct: -3.5,
    renewable_energy_pct: 30, tourism_gdp_pct: 3.0, protected_areas_pct: 13,
    paris_agreement_ratified: true, paris_ratification_date: "2017-10-06"
  },
  {
    name: "Austria", name_fr: "Autriche", iso_code: "AUT", continent: "Europe",
    flag_emoji: "🇦🇹", capital: "Vienne", latitude: 48.21, longitude: 16.37,
    cat_rating: "insufficient", ccpi_score: 49.0, ccpi_rank: 36,
    emissions_per_capita: 7.0, total_emissions_mt: 63.0, emissions_trend_pct: -4.0,
    renewable_energy_pct: 36, tourism_gdp_pct: 7.5, protected_areas_pct: 29,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Belgium", name_fr: "Belgique", iso_code: "BEL", continent: "Europe",
    flag_emoji: "🇧🇪", capital: "Bruxelles", latitude: 50.85, longitude: 4.35,
    cat_rating: "insufficient", ccpi_score: 46.0, ccpi_rank: 39,
    emissions_per_capita: 8.2, total_emissions_mt: 95.0, emissions_trend_pct: -2.5,
    renewable_energy_pct: 15, tourism_gdp_pct: 2.8, protected_areas_pct: 14,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Ireland", name_fr: "Irlande", iso_code: "IRL", continent: "Europe",
    flag_emoji: "🇮🇪", capital: "Dublin", latitude: 53.35, longitude: -6.26,
    cat_rating: "insufficient", ccpi_score: 42.0, ccpi_rank: 46,
    emissions_per_capita: 7.7, total_emissions_mt: 39.0, emissions_trend_pct: -2.0,
    renewable_energy_pct: 16, tourism_gdp_pct: 4.5, protected_areas_pct: 15,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Colombia", name_fr: "Colombie", iso_code: "COL", continent: "Amérique_du_Sud",
    flag_emoji: "🇨🇴", capital: "Bogotá", latitude: 4.71, longitude: -74.07,
    cat_rating: "insufficient", ccpi_score: 47.0, ccpi_rank: 38,
    emissions_per_capita: 1.8, total_emissions_mt: 92.0, emissions_trend_pct: 1.5,
    renewable_energy_pct: 27, tourism_gdp_pct: 2.5, protected_areas_pct: 15,
    paris_agreement_ratified: true, paris_ratification_date: "2018-07-12"
  },
  {
    name: "Peru", name_fr: "Pérou", iso_code: "PER", continent: "Amérique_du_Sud",
    flag_emoji: "🇵🇪", capital: "Lima", latitude: -12.05, longitude: -77.04,
    cat_rating: "insufficient", ccpi_score: 50.0, ccpi_rank: 34,
    emissions_per_capita: 1.8, total_emissions_mt: 60.0, emissions_trend_pct: 2.0,
    renewable_energy_pct: 25, tourism_gdp_pct: 3.8, protected_areas_pct: 18,
    paris_agreement_ratified: true, paris_ratification_date: "2016-07-25"
  },
  {
    name: "Czech Republic", name_fr: "Tchéquie", iso_code: "CZE", continent: "Europe",
    flag_emoji: "🇨🇿", capital: "Prague", latitude: 50.08, longitude: 14.44,
    cat_rating: "insufficient", ccpi_score: 43.0, ccpi_rank: 44,
    emissions_per_capita: 9.3, total_emissions_mt: 100.0, emissions_trend_pct: -2.0,
    renewable_energy_pct: 17, tourism_gdp_pct: 2.9, protected_areas_pct: 22,
    paris_agreement_ratified: true, paris_ratification_date: "2017-10-05"
  },
  {
    name: "Croatia", name_fr: "Croatie", iso_code: "HRV", continent: "Europe",
    flag_emoji: "🇭🇷", capital: "Zagreb", latitude: 45.81, longitude: 15.98,
    cat_rating: "insufficient", ccpi_score: 44.0, ccpi_rank: 42,
    emissions_per_capita: 4.5, total_emissions_mt: 18.0, emissions_trend_pct: -1.5,
    renewable_energy_pct: 29, tourism_gdp_pct: 20.0, protected_areas_pct: 37,
    paris_agreement_ratified: true, paris_ratification_date: "2017-05-24"
  },
  {
    name: "Vietnam", name_fr: "Vietnam", iso_code: "VNM", continent: "Asie",
    flag_emoji: "🇻🇳", capital: "Hanoï", latitude: 21.03, longitude: 105.85,
    cat_rating: "insufficient", ccpi_score: 40.0, ccpi_rank: 49,
    emissions_per_capita: 3.5, total_emissions_mt: 344.0, emissions_trend_pct: 5.0,
    renewable_energy_pct: 11, tourism_gdp_pct: 7.0, protected_areas_pct: 10,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-03"
  },
  {
    name: "Egypt", name_fr: "Égypte", iso_code: "EGY", continent: "Afrique",
    flag_emoji: "🇪🇬", capital: "Le Caire", latitude: 30.04, longitude: 31.24,
    cat_rating: "insufficient", ccpi_score: 52.0, ccpi_rank: 32,
    emissions_per_capita: 2.6, total_emissions_mt: 271.0, emissions_trend_pct: 2.5,
    renewable_energy_pct: 12, tourism_gdp_pct: 11.0, protected_areas_pct: 13,
    paris_agreement_ratified: true, paris_ratification_date: "2017-06-29"
  },
  {
    name: "Tunisia", name_fr: "Tunisie", iso_code: "TUN", continent: "Afrique",
    flag_emoji: "🇹🇳", capital: "Tunis", latitude: 36.81, longitude: 10.18,
    cat_rating: "insufficient", ccpi_score: 48.0, ccpi_rank: 37,
    emissions_per_capita: 2.8, total_emissions_mt: 34.0, emissions_trend_pct: 1.0,
    renewable_energy_pct: 6, tourism_gdp_pct: 14.0, protected_areas_pct: 8,
    paris_agreement_ratified: true, paris_ratification_date: "2017-02-10"
  },
  {
    name: "Cuba", name_fr: "Cuba", iso_code: "CUB", continent: "Amérique_du_Nord",
    flag_emoji: "🇨🇺", capital: "La Havane", latitude: 23.11, longitude: -82.37,
    cat_rating: "insufficient", ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 2.5, total_emissions_mt: 28.0, emissions_trend_pct: -1.0,
    renewable_energy_pct: 5, tourism_gdp_pct: 10.0, protected_areas_pct: 17,
    paris_agreement_ratified: true, paris_ratification_date: "2017-01-28"
  },

  # ══════════════════════════════════════════════
  # HIGHLY INSUFFICIENT
  # ══════════════════════════════════════════════

  {
    name: "South Korea", name_fr: "Corée du Sud", iso_code: "KOR", continent: "Asie",
    flag_emoji: "🇰🇷", capital: "Séoul", latitude: 37.57, longitude: 126.98,
    cat_rating: "highly_insufficient", ccpi_score: 38.0, ccpi_rank: 54,
    emissions_per_capita: 11.6, total_emissions_mt: 601.0, emissions_trend_pct: -1.0,
    renewable_energy_pct: 9, tourism_gdp_pct: 2.8, protected_areas_pct: 17,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-03"
  },
  {
    name: "Indonesia", name_fr: "Indonésie", iso_code: "IDN", continent: "Asie",
    flag_emoji: "🇮🇩", capital: "Jakarta", latitude: -6.21, longitude: 106.85,
    cat_rating: "highly_insufficient", ccpi_score: 39.0, ccpi_rank: 52,
    emissions_per_capita: 2.3, total_emissions_mt: 640.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 14, tourism_gdp_pct: 4.5, protected_areas_pct: 14,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-31"
  },
  {
    name: "South Africa", name_fr: "Afrique du Sud", iso_code: "ZAF", continent: "Afrique",
    flag_emoji: "🇿🇦", capital: "Pretoria", latitude: -25.75, longitude: 28.19,
    cat_rating: "highly_insufficient", ccpi_score: 39.0, ccpi_rank: 51,
    emissions_per_capita: 7.3, total_emissions_mt: 435.0, emissions_trend_pct: 0.5,
    renewable_energy_pct: 11, tourism_gdp_pct: 3.5, protected_areas_pct: 8,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-01"
  },
  {
    name: "Argentina", name_fr: "Argentine", iso_code: "ARG", continent: "Amérique_du_Sud",
    flag_emoji: "🇦🇷", capital: "Buenos Aires", latitude: -34.60, longitude: -58.38,
    cat_rating: "highly_insufficient", ccpi_score: 41.0, ccpi_rank: 47,
    emissions_per_capita: 4.0, total_emissions_mt: 183.0, emissions_trend_pct: 1.0,
    renewable_energy_pct: 14, tourism_gdp_pct: 3.5, protected_areas_pct: 9,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Poland", name_fr: "Pologne", iso_code: "POL", continent: "Europe",
    flag_emoji: "🇵🇱", capital: "Varsovie", latitude: 52.23, longitude: 21.01,
    cat_rating: "highly_insufficient", ccpi_score: 34.0, ccpi_rank: 57,
    emissions_per_capita: 8.1, total_emissions_mt: 307.0, emissions_trend_pct: -1.0,
    renewable_energy_pct: 17, tourism_gdp_pct: 4.5, protected_areas_pct: 40,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-07"
  },
  {
    name: "Malaysia", name_fr: "Malaisie", iso_code: "MYS", continent: "Asie",
    flag_emoji: "🇲🇾", capital: "Kuala Lumpur", latitude: 3.14, longitude: 101.69,
    cat_rating: "highly_insufficient", ccpi_score: 36.0, ccpi_rank: 56,
    emissions_per_capita: 8.0, total_emissions_mt: 263.0, emissions_trend_pct: 2.0,
    renewable_energy_pct: 8, tourism_gdp_pct: 5.8, protected_areas_pct: 19,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-16"
  },
  {
    name: "Singapore", name_fr: "Singapour", iso_code: "SGP", continent: "Asie",
    flag_emoji: "🇸🇬", capital: "Singapour", latitude: 1.35, longitude: 103.82,
    cat_rating: "highly_insufficient", ccpi_score: 30.0, ccpi_rank: 59,
    emissions_per_capita: 8.9, total_emissions_mt: 51.0, emissions_trend_pct: 0.5,
    renewable_energy_pct: 3, tourism_gdp_pct: 4.0, protected_areas_pct: 6,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Cambodia", name_fr: "Cambodge", iso_code: "KHM", continent: "Asie",
    flag_emoji: "🇰🇭", capital: "Phnom Penh", latitude: 11.56, longitude: 104.92,
    cat_rating: "highly_insufficient", ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 1.2, total_emissions_mt: 20.0, emissions_trend_pct: 6.0,
    renewable_energy_pct: 7, tourism_gdp_pct: 18.0, protected_areas_pct: 26,
    paris_agreement_ratified: true, paris_ratification_date: "2017-02-06"
  },
  {
    name: "Sri Lanka", name_fr: "Sri Lanka", iso_code: "LKA", continent: "Asie",
    flag_emoji: "🇱🇰", capital: "Colombo", latitude: 6.93, longitude: 79.84,
    cat_rating: "highly_insufficient", ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 1.0, total_emissions_mt: 22.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 14, tourism_gdp_pct: 5.0, protected_areas_pct: 32,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },

  # ══════════════════════════════════════════════
  # CRITICALLY INSUFFICIENT
  # ══════════════════════════════════════════════

  {
    name: "Iran", name_fr: "Iran", iso_code: "IRN", continent: "Asie",
    flag_emoji: "🇮🇷", capital: "Téhéran", latitude: 35.69, longitude: 51.39,
    cat_rating: "critically_insufficient", ccpi_score: 19.0, ccpi_rank: 66,
    emissions_per_capita: 9.1, total_emissions_mt: 785.0, emissions_trend_pct: 2.0,
    renewable_energy_pct: 6, tourism_gdp_pct: 2.5, protected_areas_pct: 10,
    paris_agreement_signed: true, paris_agreement_ratified: false
  },

  # ══════════════════════════════════════════════
  # PAYS TOURISTIQUES SANS NOTE CAT
  # (score basé sur émissions/hab + CCPI + renouvelables)
  # ══════════════════════════════════════════════

  {
    name: "Iceland", name_fr: "Islande", iso_code: "ISL", continent: "Europe",
    flag_emoji: "🇮🇸", capital: "Reykjavik", latitude: 64.15, longitude: -21.94,
    cat_rating: nil, ccpi_score: 54.0, ccpi_rank: 26,
    emissions_per_capita: 9.5, total_emissions_mt: 3.5, emissions_trend_pct: -2.0,
    renewable_energy_pct: 100, tourism_gdp_pct: 8.0, protected_areas_pct: 25,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Dominican Republic", name_fr: "République Dominicaine", iso_code: "DOM", continent: "Amérique_du_Nord",
    flag_emoji: "🇩🇴", capital: "Saint-Domingue", latitude: 18.49, longitude: -69.90,
    cat_rating: nil, ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 2.4, total_emissions_mt: 26.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 12, tourism_gdp_pct: 17.0, protected_areas_pct: 26,
    paris_agreement_ratified: true, paris_ratification_date: "2017-09-21"
  },
  {
    name: "Tanzania", name_fr: "Tanzanie", iso_code: "TZA", continent: "Afrique",
    flag_emoji: "🇹🇿", capital: "Dodoma", latitude: -6.16, longitude: 35.74,
    cat_rating: nil, ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 0.2, total_emissions_mt: 14.0, emissions_trend_pct: 4.0,
    renewable_energy_pct: 50, tourism_gdp_pct: 10.5, protected_areas_pct: 38,
    paris_agreement_ratified: true, paris_ratification_date: "2018-04-18"
  },
  {
    name: "Jordan", name_fr: "Jordanie", iso_code: "JOR", continent: "Asie",
    flag_emoji: "🇯🇴", capital: "Amman", latitude: 31.95, longitude: 35.93,
    cat_rating: nil, ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 2.7, total_emissions_mt: 30.0, emissions_trend_pct: 1.5,
    renewable_energy_pct: 13, tourism_gdp_pct: 11.0, protected_areas_pct: 10,
    paris_agreement_ratified: true, paris_ratification_date: "2016-11-04"
  },
  {
    name: "Senegal", name_fr: "Sénégal", iso_code: "SEN", continent: "Afrique",
    flag_emoji: "🇸🇳", capital: "Dakar", latitude: 14.72, longitude: -17.47,
    cat_rating: nil, ccpi_score: nil, ccpi_rank: nil,
    emissions_per_capita: 0.7, total_emissions_mt: 12.0, emissions_trend_pct: 3.0,
    renewable_energy_pct: 12, tourism_gdp_pct: 6.0, protected_areas_pct: 25,
    paris_agreement_ratified: true, paris_ratification_date: "2016-09-21"
  },
  {
    name: "Hungary", name_fr: "Hongrie", iso_code: "HUN", continent: "Europe",
    flag_emoji: "🇭🇺", capital: "Budapest", latitude: 47.50, longitude: 19.04,
    cat_rating: nil, ccpi_score: 39.0, ccpi_rank: 53,
    emissions_per_capita: 5.0, total_emissions_mt: 49.0, emissions_trend_pct: -1.5,
    renewable_energy_pct: 14, tourism_gdp_pct: 6.8, protected_areas_pct: 22,
    paris_agreement_ratified: true, paris_ratification_date: "2016-10-05"
  },
  {
    name: "Romania", name_fr: "Roumanie", iso_code: "ROU", continent: "Europe",
    flag_emoji: "🇷🇴", capital: "Bucarest", latitude: 44.43, longitude: 26.10,
    cat_rating: nil, ccpi_score: 41.0, ccpi_rank: 48,
    emissions_per_capita: 3.8, total_emissions_mt: 73.0, emissions_trend_pct: -2.0,
    renewable_energy_pct: 24, tourism_gdp_pct: 2.8, protected_areas_pct: 23,
    paris_agreement_ratified: true, paris_ratification_date: "2017-06-01"
  },
]

# ─── DESTINATIONS ADDITIONNELLES ────────────────────────────────────
additional_destinations = [
  # Sweden
  { country_iso: "SWE", name: "Stockholm", latitude: 59.33, longitude: 18.07,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Venise du Nord, archipel de 14 îles et musées de classe mondiale" },
  { country_iso: "SWE", name: "Göteborg", latitude: 57.71, longitude: 12.00,
    accessible_by_train: true, tourism_pressure: "low", featured: false,
    description_fr: "Capitale gastronomique suédoise, charme côtier et développement durable" },

  # Chile
  { country_iso: "CHL", name: "Valparaíso", latitude: -33.05, longitude: -71.62,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Ville colorée, street art et collines escarpées face au Pacifique" },

  # Finland
  { country_iso: "FIN", name: "Helsinki", latitude: 60.17, longitude: 24.94,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Design nordique, saunas publics et archipel accessible en ferry" },

  # Philippines
  { country_iso: "PHL", name: "Palawan", latitude: 9.84, longitude: 118.72,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Lagons turquoise, rivière souterraine et biodiversité marine" },

  # New Zealand
  { country_iso: "NZL", name: "Queenstown", latitude: -45.03, longitude: 168.66,
    accessible_by_train: false, tourism_pressure: "high", featured: true,
    description_fr: "Capitale de l'aventure, fjords et montagnes spectaculaires" },

  # Switzerland
  { country_iso: "CHE", name: "Lucerne", latitude: 47.05, longitude: 8.31,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Lac alpin, pont de la Chapelle et panorama sur les Alpes" },
  { country_iso: "CHE", name: "Zermatt", latitude: 46.02, longitude: 7.75,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Village sans voitures au pied du Cervin, ski et randonnée" },

  # Austria
  { country_iso: "AUT", name: "Vienne", latitude: 48.21, longitude: 16.37,
    accessible_by_train: true, tourism_pressure: "high", featured: true,
    description_fr: "Palais impériaux, cafés historiques et scène musicale classique" },
  { country_iso: "AUT", name: "Salzbourg", latitude: 47.80, longitude: 13.04,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Ville natale de Mozart, festival de musique et lacs alpins" },

  # Czech Republic
  { country_iso: "CZE", name: "Prague", latitude: 50.08, longitude: 14.44,
    accessible_by_train: true, tourism_pressure: "overtourism", featured: true,
    description_fr: "Ville aux cent clochers, pont Charles et bière artisanale" },
  { country_iso: "CZE", name: "Český Krumlov", latitude: 48.81, longitude: 14.32,
    accessible_by_train: true, tourism_pressure: "high", featured: false,
    description_fr: "Joyau médiéval classé UNESCO au bord de la Vltava" },

  # Croatia
  { country_iso: "HRV", name: "Dubrovnik", latitude: 42.65, longitude: 18.09,
    accessible_by_train: false, tourism_pressure: "overtourism", featured: true,
    description_fr: "Perle de l'Adriatique, remparts et eaux cristallines" },
  { country_iso: "HRV", name: "Split", latitude: 43.51, longitude: 16.44,
    accessible_by_train: false, tourism_pressure: "high", featured: false,
    description_fr: "Palais de Dioclétien et porte d'entrée des îles dalmates" },

  # Colombia
  { country_iso: "COL", name: "Carthagène", latitude: 10.39, longitude: -75.51,
    accessible_by_train: false, tourism_pressure: "high", featured: true,
    description_fr: "Cité coloniale colorée, salsa et cuisine caribéenne" },
  { country_iso: "COL", name: "Medellín", latitude: 6.25, longitude: -75.56,
    accessible_by_train: false, tourism_pressure: "moderate", featured: false,
    description_fr: "Ville de l'éternel printemps, innovation urbaine et street art" },

  # Peru
  { country_iso: "PER", name: "Cusco", latitude: -13.52, longitude: -71.97,
    accessible_by_train: true, tourism_pressure: "high", featured: true,
    description_fr: "Ancienne capitale inca, porte du Machu Picchu" },

  # South Korea
  { country_iso: "KOR", name: "Séoul", latitude: 37.57, longitude: 126.98,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Mégapole entre palais ancestraux et quartiers futuristes" },
  { country_iso: "KOR", name: "Busan", latitude: 35.18, longitude: 129.08,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Plages, marchés aux poissons et temples en bord de mer" },

  # Indonesia
  { country_iso: "IDN", name: "Bali", latitude: -8.34, longitude: 115.09,
    accessible_by_train: false, tourism_pressure: "overtourism", featured: true,
    description_fr: "Île des dieux, rizières en terrasses et temples hindous" },
  { country_iso: "IDN", name: "Yogyakarta", latitude: -7.80, longitude: 110.36,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Capitale culturelle javanaise, Borobudur et Prambanan" },

  # South Africa
  { country_iso: "ZAF", name: "Le Cap", latitude: -33.93, longitude: 18.42,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Table Mountain, vignobles et biodiversité unique au monde" },

  # Argentina
  { country_iso: "ARG", name: "Buenos Aires", latitude: -34.60, longitude: -58.38,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Paris de l'Amérique du Sud, tango, steaks et architecture" },
  { country_iso: "ARG", name: "Patagonie / El Calafate", latitude: -50.34, longitude: -72.26,
    accessible_by_train: false, tourism_pressure: "low", featured: false,
    description_fr: "Glacier Perito Moreno et steppes infinies" },

  # Egypt
  { country_iso: "EGY", name: "Louxor", latitude: 25.70, longitude: 32.64,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Vallée des Rois, temples de Karnak et croisières sur le Nil" },

  # Vietnam
  { country_iso: "VNM", name: "Hội An", latitude: 15.88, longitude: 108.33,
    accessible_by_train: true, tourism_pressure: "high", featured: true,
    description_fr: "Ville-lanterne classée UNESCO, cuisine de rue et plages" },
  { country_iso: "VNM", name: "Hanoï", latitude: 21.03, longitude: 105.85,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Vieux quartier millénaire, lac Hoàn Kiếm et phở" },

  # Iceland
  { country_iso: "ISL", name: "Reykjavik", latitude: 64.15, longitude: -21.94,
    accessible_by_train: false, tourism_pressure: "high", featured: true,
    description_fr: "Capitale la plus septentrionale, aurores boréales et geysers" },

  # Jordan
  { country_iso: "JOR", name: "Pétra", latitude: 30.33, longitude: 35.44,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Cité nabatéenne taillée dans le grès rose, merveille du monde" },

  # Tanzania
  { country_iso: "TZA", name: "Zanzibar", latitude: -6.16, longitude: 39.19,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Épices, plages de sable blanc et Stone Town classée UNESCO" },

  # Hungary
  { country_iso: "HUN", name: "Budapest", latitude: 47.50, longitude: 19.04,
    accessible_by_train: true, tourism_pressure: "high", featured: true,
    description_fr: "Thermes, rives du Danube et architecture Art Nouveau" },

  # Cambodia
  { country_iso: "KHM", name: "Siem Reap", latitude: 13.36, longitude: 103.86,
    accessible_by_train: false, tourism_pressure: "high", featured: true,
    description_fr: "Porte d'Angkor Wat, temples khmers dans la jungle" },

  # Cuba
  { country_iso: "CUB", name: "La Havane", latitude: 23.11, longitude: -82.37,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Voitures vintage, Malecón, musique et architecture coloniale" },
  { country_iso: "CUB", name: "Trinidad", latitude: 21.80, longitude: -79.98,
    accessible_by_train: false, tourism_pressure: "moderate", featured: false,
    description_fr: "Ville coloniale préservée, rues pavées et vallée sucrière" },

  # Senegal
  { country_iso: "SEN", name: "Saint-Louis", latitude: 16.02, longitude: -16.50,
    accessible_by_train: false, tourism_pressure: "low", featured: true,
    description_fr: "Ancienne capitale coloniale sur le fleuve Sénégal, jazz et pêche" },

  # Malaysia
  { country_iso: "MYS", name: "George Town", latitude: 5.41, longitude: 100.34,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Street art, temples et cuisine de rue légendaire à Penang" },

  # Sri Lanka
  { country_iso: "LKA", name: "Kandy", latitude: 7.29, longitude: 80.63,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Temple de la Dent, jardins botaniques et train panoramique" },

  # Dominican Republic
  { country_iso: "DOM", name: "Las Terrenas", latitude: 19.31, longitude: -69.54,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Plages caraïbes, communauté francophone et ambiance décontractée" },

  # Romania
  { country_iso: "ROU", name: "Brașov", latitude: 45.66, longitude: 25.61,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Porte de la Transylvanie, montagnes et cité médiévale saxonne" },
]

# ─── INSERTION ──────────────────────────────────────────────────────
# Ajouter dans le seeds.rb à la suite du bloc existant :

puts "🌍 Adding additional countries..."

additional_countries.each do |data|
  country = Country.find_or_initialize_by(iso_code: data[:iso_code])
  country.assign_attributes(data)
  country.slug = data[:name].parameterize
  country.paris_agreement_signed = true if data[:paris_agreement_signed].nil? && data[:paris_agreement_ratified]
  country.data_last_updated = Date.today
  country.save!
  country.compute_climate_score!
end

puts "  ✅ #{Country.count} pays au total"

puts "📍 Adding additional destinations..."

additional_destinations.each do |data|
  country = Country.find_by(iso_code: data.delete(:country_iso))
  next unless country

  dest = country.destinations.find_or_initialize_by(name: data[:name])
  dest.assign_attributes(data)
  dest.slug = data[:name].parameterize
  dest.save!
end

puts "  ✅ #{Destination.count} destinations au total"

# ─── UPDATED SUMMARY ───────────────────────────────────────────────
puts ""
puts "═══════════════════════════════════════════"
puts "  🌡️  1.5° Travel — Base enrichie"
puts "═══════════════════════════════════════════"
puts ""
puts "  Pays:           #{Country.count}"
puts "  Destinations:   #{Destination.count}"
puts "  Transports:     #{TransportMode.count}"
puts ""
puts "  Classement climatique:"
Country::CAT_RATINGS.each do |key, info|
  count = Country.where(cat_rating: key).count
  puts "    #{info[:emoji]} #{info[:label].ljust(25)} #{count} pays"
end
sans_cat = Country.where(cat_rating: [nil, ""]).count
puts "    ❓ Sans note CAT              #{sans_cat} pays"
puts ""
puts "  Top 10 pays par score climatique:"
Country.ranked_by_climate.limit(10).each_with_index do |c, i|
  puts "    #{(i + 1).to_s.rjust(2)}. #{c.flag_emoji} #{c.name_fr.ljust(22)} #{c.climate_score}/100 (#{c.cat_label})"
end
puts ""




countries_data.each do |data|
  country = Country.find_or_initialize_by(iso_code: data[:iso_code])
  country.assign_attributes(data)
  country.slug = data[:name].parameterize
  country.data_last_updated = Date.today
  country.save!
  country.compute_climate_score!
end

puts "  ✅ #{Country.count} pays créés avec données climatiques"

# ─── SAMPLE DESTINATIONS ──────────────────────────────────────────────
puts "📍 Creating sample destinations..."

destinations_data = [
  # Morocco
  { country_iso: "MAR", name: "Marrakech", latitude: 31.63, longitude: -8.00,
    accessible_by_train: true, tourism_pressure: "high", featured: true,
    description_fr: "Ville impériale aux souks envoûtants et jardins somptueux" },
  { country_iso: "MAR", name: "Essaouira", latitude: 31.51, longitude: -9.77,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Cité portuaire fortifiée, paradis des kitesurfeurs" },

  # Costa Rica
  { country_iso: "CRI", name: "Monteverde", latitude: 10.31, longitude: -84.82,
    accessible_by_train: false, tourism_pressure: "moderate", featured: true,
    description_fr: "Forêt de nuages et biodiversité exceptionnelle" },

  # Denmark
  { country_iso: "DNK", name: "Copenhague", latitude: 55.68, longitude: 12.57,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Capitale verte européenne, cyclable et innovante" },
  { country_iso: "DNK", name: "Aarhus", latitude: 56.15, longitude: 10.21,
    accessible_by_train: true, tourism_pressure: "low", featured: false,
    description_fr: "Deuxième ville danoise, capitale européenne de la culture 2017" },

  # France
  { country_iso: "FRA", name: "Lyon", latitude: 45.76, longitude: 4.84,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Capitale de la gastronomie, patrimoine UNESCO" },
  { country_iso: "FRA", name: "Nancy", latitude: 48.69, longitude: 6.18,
    accessible_by_train: true, tourism_pressure: "low", featured: false,
    description_fr: "Joyau Art Nouveau, place Stanislas classée UNESCO" },
  { country_iso: "FRA", name: "Marseille", latitude: 43.30, longitude: 5.37,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Cité phocéenne, calanques et mélange des cultures" },

  # Norway
  { country_iso: "NOR", name: "Bergen", latitude: 60.39, longitude: 5.32,
    accessible_by_train: true, tourism_pressure: "moderate", featured: true,
    description_fr: "Porte des fjords, maisons colorées de Bryggen" },

  # Spain
  { country_iso: "ESP", name: "Barcelone", latitude: 41.39, longitude: 2.17,
    accessible_by_train: true, tourism_pressure: "overtourism", featured: false,
    description_fr: "Architecture Gaudí et vie méditerranéenne" },
  { country_iso: "ESP", name: "Séville", latitude: 37.39, longitude: -5.98,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Flamenco, Alcázar et ambiance andalouse" },

  # Portugal
  { country_iso: "PRT", name: "Porto", latitude: 41.15, longitude: -8.61,
    accessible_by_train: true, tourism_pressure: "high", featured: false,
    description_fr: "Ville des azulejos, vignobles du Douro" },

  # Japan
  { country_iso: "JPN", name: "Kyoto", latitude: 35.01, longitude: 135.77,
    accessible_by_train: true, tourism_pressure: "high", featured: true,
    description_fr: "Ancienne capitale impériale, temples et jardins zen" },
  { country_iso: "JPN", name: "Kanazawa", latitude: 36.56, longitude: 136.66,
    accessible_by_train: true, tourism_pressure: "low", featured: false,
    description_fr: "Le petit Kyoto, jardin Kenroku-en et quartiers de geishas" },

  # Kenya
  { country_iso: "KEN", name: "Nairobi", latitude: -1.29, longitude: 36.82,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Parc national urbain unique au monde" },

  # UK
  { country_iso: "GBR", name: "Édimbourg", latitude: 55.95, longitude: -3.19,
    accessible_by_train: true, tourism_pressure: "moderate", featured: false,
    description_fr: "Capitale écossaise, château et Arthur's Seat" },

  # Nepal
  { country_iso: "NPL", name: "Pokhara", latitude: 28.21, longitude: 83.99,
    accessible_by_train: false, tourism_pressure: "moderate", featured: false,
    description_fr: "Lac Fewa, porte de l'Annapurna" },
]

destinations_data.each do |data|
  country = Country.find_by(iso_code: data.delete(:country_iso))
  next unless country

  dest = country.destinations.find_or_initialize_by(name: data[:name])
  dest.assign_attributes(data)
  dest.slug = data[:name].parameterize
  dest.save!
end

puts "  ✅ #{Destination.count} destinations créées"

# ─── SUMMARY ──────────────────────────────────────────────────────────
puts ""
puts "═══════════════════════════════════════"
puts "  🌡️  1.5° Travel — Base de données prête"
puts "═══════════════════════════════════════"
puts ""
puts "  Pays:           #{Country.count}"
puts "  Destinations:   #{Destination.count}"
puts "  Transports:     #{TransportMode.count}"
puts ""
puts "  Classement climatique:"
Country::CAT_RATINGS.each do |key, info|
  count = Country.where(cat_rating: key).count
  puts "    #{info[:emoji]} #{info[:label].ljust(25)} #{count} pays"
end
puts ""
puts "  Top 5 pays par score climatique:"
Country.ranked_by_climate.limit(5).each_with_index do |c, i|
  puts "    #{i + 1}. #{c.flag_emoji} #{c.name_fr.ljust(20)} #{c.climate_score}/100 (#{c.cat_label})"
end
puts ""


# Coller ce code dans db/seeds.rb ou lancer avec: rails runner db/seed_transport_modes.rb
#
# Crée les modes de transport avec les facteurs d'émission ADEME Base Empreinte

puts "🚂 Seeding transport modes..."

modes = [
  { name: "train",         name_fr: "Train",               icon: "🚄", co2_per_km: 0.006,  active: true },
  { name: "bus",           name_fr: "Bus / Car",           icon: "🚌", co2_per_km: 0.030,  active: true },
  { name: "electric_car",  name_fr: "Voiture électrique",  icon: "⚡", co2_per_km: 0.020,  active: true },
  { name: "car",           name_fr: "Voiture",             icon: "🚗", co2_per_km: 0.110,  active: true },
  { name: "ferry",         name_fr: "Ferry",               icon: "⛴️",  co2_per_km: 0.120,  active: true },
  { name: "plane_short",   name_fr: "Avion court-courrier",icon: "✈️",  co2_per_km: 0.230,  active: true },
  { name: "plane",         name_fr: "Avion long-courrier", icon: "🛫", co2_per_km: 0.190,  active: true }
]

modes.each do |attrs|
  mode = TransportMode.find_or_initialize_by(name: attrs[:name])
  mode.assign_attributes(attrs)
  mode.save!
  puts "  ✅ #{mode.name_fr} — #{(mode.co2_per_km * 1000).round(0)} g CO₂/km"
end

puts "✅ #{TransportMode.count} transport modes ready."
