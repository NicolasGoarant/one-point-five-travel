class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def index
    @trips = current_user.trips.order(created_at: :desc).includes(:country, :transport_mode)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
    @countries = Country.where.not(climate_score: nil).order(climate_score: :desc)
    @transport_modes = TransportMode.where(active: true).order(:co2_per_km)
  end

  def create
    @trip = Trip.new(trip_params)

    if user_signed_in?
      @trip.user = current_user
    else
      @trip.user = User.new(
        email: "preview_#{SecureRandom.hex(8)}@temp.local",
        password: SecureRandom.hex(16),
        climate_weight: 30, transport_weight: 40, local_impact_weight: 30
      )
    end

    if @trip.distance_km.blank? && @trip.country.present?
      @trip.distance_km = DistanceCalculator.estimate(
        origin_lat: @trip.origin_latitude || 48.6937,
        origin_lng: @trip.origin_longitude || 6.1834,
        dest_lat: @trip.country.latitude,
        dest_lng: @trip.country.longitude
      )
    end

    result = TripScoringService.new(@trip).call
    @trip.assign_attributes(result)
    @trip.status = "calculated"

    if @trip.save
      redirect_to trip_path(@trip), notice: "Votre score voyage a été calculé !"
    else
      @countries = Country.where.not(climate_score: nil).order(climate_score: :desc)
      @transport_modes = TransportMode.where(active: true).order(:co2_per_km)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @trip = current_user.trips.find(params[:id])
    @trip.destroy
    redirect_to trips_path, notice: "Voyage supprimé."
  end

  private

  def trip_params
    params.require(:trip).permit(
      :country_id, :destination_id, :transport_mode_id,
      :origin_city, :origin_country_iso, :origin_latitude, :origin_longitude,
      :distance_km, :duration_days, :travelers_count,
      :departure_date, :return_date
    )
  end
end
