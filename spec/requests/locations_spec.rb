require 'rails_helper'

RSpec.describe "Locations", type: :request do
  let(:tampa_location) { create(:location)}

  describe "GET /" do
    it "should let user to view the locations show template" do
      get "/"
      expect(response).to render_template(:show)
    end
  end

  describe "GET /weather" do
    it "should respond with 400 if request miss coordinates/search city " do
      get "/weather.json", :params => { search: "" }
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(parsed_response["message"]).to eq("please provide valid search details")
    end

    it "should return the weather condition of searched city" do
      VCR.use_cassette("get_weather") do
        get "/weather.json", :params => { search: "Tampa" }
      end
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response["name"]).to eq("Tampa")
      expect(parsed_response.keys).to include("condition")
    end

    it "should return the weather condition of city with searched coordinates" do
      VCR.use_cassette("get_weather_by_delaware_coordinates") do
        get "/weather.json", :params => { coordinates: "40.36,-82.99" }
      end
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_response["name"]).to eq("Delaware")
      expect(parsed_response.keys).to include("condition")
    end

    it "should create a location if theres no location record with that city name" do 
      count = Location.count
      VCR.use_cassette("get_weather") do
        get "/weather.json", :params => { search: "Tampa" }
      end

      expect(response.status).to eq(200)
      expect(Location.count).to eq(count+1)
    end
    
    it "should not create a location record if there's already a record with that city name" do 
      tampa_location
      count = Location.count
      VCR.use_cassette("get_weather") do
        get "/weather.json", :params => { search: "Tampa" }
      end

      expect(response.status).to eq(200)
      expect(Location.count).to eq(count)
    end

    it "should create a location if theres no location record with requested coordinates" do 
      count = Location.count
      VCR.use_cassette("get_weather_by_coordinates") do
        get "/weather.json", :params => { coordinates: "27.95,-82.46" }
      end

      expect(response.status).to eq(200)
      expect(Location.count).to eq(count+1)
    end

    it "should not create a location record if there's already a record with requested coordinates" do 
      tampa_location
      count = Location.count
      VCR.use_cassette("get_weather_by_coordinates") do
        get "/weather.json", :params => { coordinates: "27.95,-82.46" }
      end

      expect(response.status).to eq(200)
      expect(Location.count).to eq(count)
    end

    it "should re-create location record if it go old by 1 hour" do
      tampa_location.update(updated_at: Time.zone.now - 1.hour)
      count = Location.count
      VCR.use_cassette("get_weather") do
        get "/weather.json", :params => { search: "Tampa" }
      end

      expect(response.status).to eq(200)
      expect(Location.count).to eq(count)
      expect(Location.find_by(id: tampa_location.id)).to be nil
      expect(Location.find_by(name: "Tampa")).to_not be nil
    end
  end
end 
