class LocationsController < ApplicationController
  before_action :check_location, only: :get_weather

  def show; end

  def get_weather
    location, search_param = check_location

    @location = if location.nil?
                  LocationCreator.call(search_param)
                elsif location.present? && (location.updated_at < Time.now - 1.hour)
                  location.delete
                  LocationCreator.call(search_param)
                else
                  location
                end
  end

  private

  def check_location
    if params['coordinates'].present?
      lat, lon = params['coordinates'].split(',')
      location = Location.find_by(lat: lat, lon: lon)
      search_param = params['coordinates']
    elsif params['search'].present?
      location = Location.where(name: params['search']).or(Location.where(region: params['search'])).last
      search_param = params['search']
    else
      render json: { message: "please provide valid search details"}, status: :bad_request and return
    end
    [location, search_param]
  end
end
