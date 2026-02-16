class PagesController < ApplicationController
  def home
    @top_countries = Country.ranked_by_climate.limit(6)
    @featured_destinations = Destination.featured.includes(:country).limit(6)
    @total_countries = Country.count
    @paris_compatible_count = Country.paris_compatible.count
    @countries_data = Country.where.not(climate_score: nil).map { |c|
      {
        iso_code: c.iso_code,
        name_fr: c.name_fr,
        climate_score: c.climate_score,
        grade: c.grade,
        grade_color: c.grade_color,
        cat_label: c.cat_label,
        flag_emoji: c.flag_emoji,
        path: "/countries/#{c.id}"
      }
    }.to_json
  end

  def about
  end

  def methodology
  end

  def pourquoi
  end

  def carte
    @countries_data = Country.where.not(climate_score: nil).map { |c|
      {
        iso_code: c.iso_code,
        name_fr: c.name_fr,
        climate_score: c.climate_score,
        grade: c.grade,
        grade_color: c.grade_color,
        cat_label: c.cat_label,
        flag_emoji: c.flag_emoji,
        path: "/countries/#{c.id}"
      }
    }.to_json
  end

end
