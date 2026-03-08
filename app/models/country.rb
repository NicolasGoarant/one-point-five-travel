class Country < ApplicationRecord
  has_many :destinations, dependent: :destroy
  has_many :trips, dependent: :nullify
  validates :name, :name_fr, :iso_code, presence: true
  validates :iso_code, uniqueness: true, length: { is: 3 }
  scope :ranked_by_climate, -> { where.not(climate_score: nil).order(climate_score: :desc) }
  scope :paris_compatible, -> { where(cat_rating: %w[1.5c_compatible almost_sufficient]) }
  scope :by_continent, ->(continent) { where(continent: continent) }

  CAT_RATINGS = {
    "1.5c_compatible"         => { label: "Compatible 1.5°C", color: "#2D9D3A", score: 100, emoji: "🟢" },
    "almost_sufficient"       => { label: "Presque suffisant", color: "#7BBF2A", score: 75,  emoji: "🟡" },
    "insufficient"            => { label: "Insuffisant",       color: "#F5C542", score: 50,  emoji: "🟠" },
    "highly_insufficient"     => { label: "Très insuffisant",  color: "#E8822A", score: 25,  emoji: "🔴" },
    "critically_insufficient" => { label: "Critique",          color: "#C62828", score: 10,  emoji: "⛔" }
  }.freeze

  CONTINENTS = %w[Europe Asie Afrique Amérique_du_Nord Amérique_du_Sud Océanie].freeze

  # Pays sans article (îles, cités-États, exceptions)
  SANS_ARTICLE = %w[
    Cuba Israël Madagascar Malte Monaco Singapour Chypre Bahreïn
    Djibouti Haïti Oman Taïwan Nauru Tuvalu Vanuatu Fidji
  ].freeze

  # Pays pluriels → "les"
  PLURIELS = [
    "États-Unis", "Pays-Bas", "Philippines", "Émirats arabes unis",
    "Comores", "Maldives", "Seychelles", "Îles Marshall", "Îles Salomon",
    "Tonga", "Bahamas"
  ].freeze

  # Pays masculins malgré le "e" final
  MASCULINS_EN_E = %w[
    Mexique Mozambique Cambodge Zimbabwe Belize Suriname
  ].freeze

  # ── Nom avec article défini (pour les phrases) ──
  # "la France", "le Costa Rica", "l'Allemagne", "les États-Unis"
  def name_with_article
    return name_fr if SANS_ARTICLE.include?(name_fr)
    return "les #{name_fr}" if PLURIELS.include?(name_fr)

    if name_fr.match?(/\A[AEIOUÉÈÊËÎÏÔÛÜÂÀaeiou]/i)
      "l'#{name_fr}"
    elsif name_fr.end_with?("e") && !MASCULINS_EN_E.include?(name_fr)
      "la #{name_fr}"
    else
      "le #{name_fr}"
    end
  end

  # Variante capitalisée pour début de phrase : "La France", "Le Costa Rica"
  def name_with_article_cap
    name_with_article.sub(/\A(l'|le |la |les )/) { |m| m == "l'" ? "L'" : m.capitalize }
  end

  def compute_climate_score!
    scores = []
    weights = []

    if cat_rating.present?
      scores << CAT_RATINGS.dig(cat_rating, :score).to_f
      weights << 40
    end

    if ccpi_score.present?
      scores << ccpi_score
      weights << 25
    end

    if emissions_per_capita.present?
      epc_score = [100 - (emissions_per_capita * 5), 0].max
      scores << epc_score
      weights << 20
    end

    if renewable_energy_pct.present?
      scores << renewable_energy_pct.to_f
      weights << 10
    end

    if emissions_trend_pct.present?
      trend_score = if emissions_trend_pct <= -5
                      100
                    elsif emissions_trend_pct <= 0
                      75
                    elsif emissions_trend_pct <= 3
                      40
                    else
                      10
                    end
      scores << trend_score
      weights << 5
    end

    return update(climate_score: 0) if weights.empty?

    weighted_sum = scores.zip(weights).sum { |s, w| s * w }
    total_weight = weights.sum
    update!(climate_score: (weighted_sum / total_weight).round(1))
  end

  def cat_rating_info
    CAT_RATINGS[cat_rating] || { label: "Non évalué", color: "#999", score: 0, emoji: "❓" }
  end

  def cat_label
    cat_rating_info[:label]
  end

  def cat_color
    cat_rating_info[:color]
  end

  def grade
    case climate_score
    when 80..100 then "A"
    when 60..79  then "B"
    when 40..59  then "C"
    when 20..39  then "D"
    else              "E"
    end
  end

  def grade_color
    { "A" => "#2D9D3A", "B" => "#7BBF2A", "C" => "#F5C542", "D" => "#E8822A", "E" => "#C62828" }[grade]
  end

  def paris_status_label
    if !paris_agreement_signed
      "Non signataire"
    elsif !paris_agreement_ratified
      "Signé, non ratifié"
    else
      "Ratifié"
    end
  end
end
