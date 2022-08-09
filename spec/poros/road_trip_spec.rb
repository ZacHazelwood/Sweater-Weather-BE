require 'rails_helper'

RSpec.describe RoadTrip do
  xit "exists and has attributes" do
    trip = RoadTrip.new("denver,co", "las vegas, nv")

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq("denver, co")
    expect(trip.end_city).to eq("las vegas, nv")
    expect(trip.travel_time).to be_a String
    # expect(trip.weather_at_eta)
  end

  it "can be an object with an impossible route" do
    trip = RoadTrip.new("denver, co", "tokyo, japan")

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq("denver, co")
    expect(trip.end_city).to eq("tokyo, japan")
    expect(trip.travel_time).to eq("impossible route")
    expect(trip.weather_at_eta).to eq(nil)
  end
end
