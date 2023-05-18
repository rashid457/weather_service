class LocationCreator < ApplicationService
  def initialize(search_param)
    @search_param = search_param
  end

  def call
    response = RestClient.get "http://api.weatherapi.com/v1/current.json?key=#{ENV['WEATHER_API_KEY']}&q=#{@search_param}"
    response = JSON.parse(response)
    build_location(response)
  end

  def build_location(response)
    Location.create({
                      name: response['location']['name'],
                      region: response['location']['region'],
                      country: response['location']['country'],
                      lat: response['location']['lat'],
                      lon: response['location']['lon'],
                      condition: response['current']['condition']['text'],
                      icon: "https://#{response['current']['condition']['icon']}",
                      temparature: response['current']['temp_c'],
                      wind: response['current']['wind_mph'],
                      humidity: response['current']['humidity'],
                      cloud: response['current']['cloud'],
                      last_updated_at: response['current']['last_updated_epoch']
                    })
  end
end
