require 'rails_helper'

RSpec.describe RoadTrip do
  it "exists and has attributes" do
    trip = RoadTrip.new("denver, co", "las vegas, nv")

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq("denver, co")
    expect(trip.end_city).to eq("las vegas, nv")
    expect(trip.travel_time).to be_a String
    expect(trip.weather_at_eta).to be_a Hash
    expect(trip.weather_at_eta[:temperature]).to be_a Numeric
    expect(trip.weather_at_eta[:conditions]).to be_a String
  end

  it "can be an object with an impossible route" do
    trip = RoadTrip.new("denver, co", "tokyo, japan")

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq("denver, co")
    expect(trip.end_city).to eq("tokyo, japan")
    expect(trip.travel_time).to eq("impossible route")
    expect(trip.weather_at_eta).to eq(nil)
  end

  it "can format temperature" do
    # Have to test result class, as actual result changes every hour
    trip = RoadTrip.new("denver, co", "las vegas, nv")
    
    expect(trip.format_temp("las vegas, nv")).to be_a Numeric

    trip_2 = RoadTrip.new("panama city", "toronto, canada")

    expect(trip_2.format_temp("toronto, canada")).to be_a Numeric
  end

  it "can format conditions" do
    # Have to test result class, as actual result changes every hour
    trip = RoadTrip.new("denver, co", "las vegas, nv")

    expect(trip.format_conditions("las vegas, nv")).to be_a String

    trip_2 = RoadTrip.new("panama city", "toronto, canada")

    expect(trip_2.format_conditions("toronto, canada")).to be_a String
  end
end
