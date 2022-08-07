require 'rails_helper'

RSpec.describe MapquestLocation do
  it "exists and has attributes" do
    data = {  lat: 39.738453, lng: -104.984853 }
    location = MapquestLocation.new(data)

    expect(location).to be_a MapquestLocation
    expect(location.latitude).to eq(39.738453)
    expect(location.longitude).to eq(-104.984853)
  end
end
