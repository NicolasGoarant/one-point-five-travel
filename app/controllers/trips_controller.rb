class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :show]

  def index
    @trips = current_user.trips.order(created_at: :desc).includes(:country, :transport_mode)
  end

  def show
    @trip = Trip.find(params[:id])
    @grade_info = Trip::GRADES[@trip.grade] || Trip::GRADES["C"]
    @recommendations = begin
      JSON.parse(@trip.recommendations || "[]")
    rescue JSON::ParserError
      []
    end
  end

  def new
    @trip = Trip.new(duration_days: 7, travelers_count: 1)
    load_form_data
  end

  def create
    @trip = Trip.new(trip_params)

    # ── Assign user ──
    if user_signed_in?
      @trip.user = current_user
    else
      @trip.user = User.create!(
        email: "guest_#{SecureRandom.hex(8)}@temp.local",
        password: SecureRandom.hex(16)
      )
    end

    # ── Calculate distance if missing ──
    if @trip.distance_km.blank? && @trip.country.present?
      @trip.distance_km = DistanceCalculator.estimate(
        origin_lat: @trip.origin_latitude || 48.6937,
        origin_lng: @trip.origin_longitude || 6.1834,
        dest_lat:   @trip.country.latitude,
        dest_lng:   @trip.country.longitude
      )
    end

    # ── Score the trip (only if we have enough data) ──
    if @trip.country.present? && @trip.transport_mode.present?
      result = TripScoringService.new(@trip).call
      @trip.assign_attributes(result)
      @trip.status = "calculated"
    end

    if @trip.save
      redirect_to trip_path(@trip)
    else
      load_form_data
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @trip = current_user.trips.find(params[:id])
    @trip.destroy
    redirect_to trips_path, notice: "Voyage supprimé."
  end

  private

  def load_form_data
    @countries = Country.where.not(climate_score: nil).order(:name_fr)
    @transport_modes = TransportMode.order(:co2_per_km)
  end

  def trip_params
    params.require(:trip).permit(
      :country_id, :destination_id, :transport_mode_id,
      :origin_city, :origin_country_iso, :origin_latitude, :origin_longitude,
      :distance_km, :duration_days, :travelers_count,
      :departure_date, :return_date
    )
  end
end
