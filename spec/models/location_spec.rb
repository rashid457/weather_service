require 'rails_helper'

RSpec.describe Location, type: :model do

  it "is invalid without name" do 
    expect(build(:location, name:nil)).to_not be_valid
  end

  it "is invalid without condition" do 
    expect(build(:location, condition:nil)).to_not be_valid
  end

  it "is invalid without lat lon" do 
    expect(build(:location, lat:nil, lon:nil)).to_not be_valid
  end

  it "is valid with all attributes" do 
    expect(build(:location)).to be_valid
  end
end
