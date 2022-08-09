require 'rails_helper'

RSpec.describe RoadTripFacade do
  it "creates a road trip" do
    trip = RoadTripFacade.create_road_trip("denver, co", "sarasota, fl")

    expect(trip).to be_a RoadTrip
  end

  it "creates a road trip with an impossible route" do
    trip = RoadTripFacade.create_road_trip("denver, co", "tokyo, japan")

    expect(trip).to be_a RoadTrip
    expect(trip.travel_time).to eq("impossible route")
    expect(trip.weather_at_eta).to eq nil
  end

  it "creates a road trip that is very long" do
    trip = RoadTripFacade.create_road_trip("panama city", "toronto, canada")

    expect(trip).to be_a RoadTrip
  end
end
