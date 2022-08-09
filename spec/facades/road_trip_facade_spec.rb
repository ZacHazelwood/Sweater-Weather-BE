require 'rails_helper'

RSpec.describe RoadTripFacade do
  xit "creates a road trip" do

  end

  it "creates a road trip with an impossible route" do
    trip = RoadTripFacade.create_road_trip("denver, co", "tokyo, japan")

    expect(trip).to be_a RoadTrip
    expect(trip.travel_time).to eq("impossible route")
    expect(trip.weather_at_eta).to eq nil
  end
end
