require 'rails_helper'

RSpec.describe LocationCreator, type: :model do
  describe '#call' do
   it "creates location when city_name is passed through search_param" do 
    existing_count = Location.count 
    VCR.use_cassette("get_weather") do
      LocationCreator.call("Tampa")
    end
    
    expect(Location.count).to eq(existing_count+1)
   end

   it "creates location when location coordinates are passed through search_param" do 
    existing_count = Location.count 
    VCR.use_cassette("get_weather_by_delaware_coordinates") do
      LocationCreator.call("40.36,-82.99")
    end

    expect(Location.count).to eq(existing_count+1)
   end
  end
end