
class WeatherApiClient
  include Singleton

  class << self

    def get_data(endpoint)
     RestClient.get rest_endpoint(endpoint)
    end

    def rest_endpoint(endpoint)
      "http://api.weatherapi.com/v1/#{endpoint}&key=#{get_api_key}"
    end

    def get_api_key
      ENV['WEATHER_API_KEY']
    end
  end
end


