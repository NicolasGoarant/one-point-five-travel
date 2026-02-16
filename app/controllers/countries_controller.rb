class CountriesController < ApplicationController
  def index
    @countries = Country.where.not(climate_score: nil)
                        .order(climate_score: :desc)
    @continents = Country::CONTINENTS
    @ratings = Country::CAT_RATINGS

    if params[:continent].present?
      @countries = @countries.where(continent: params[:continent])
    end

    if params[:cat_rating].present?
      @countries = @countries.where(cat_rating: params[:cat_rating])
    end

    if params[:search].present?
      @countries = @countries.where("name ILIKE ? OR name_fr ILIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
    @country = Country.find(params[:slug] || params[:id])
    @destinations = @country.destinations
    @similar_countries = Country.where(continent: @country.continent)
                                .where.not(id: @country.id)
                                .order(climate_score: :desc)
                                .limit(4)
  end
end
