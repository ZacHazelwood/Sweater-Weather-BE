require 'rails_helper'

RSpec.describe RoadTrip do
  it "exists and has attributes" do
    trip = RoadTrip.new("denver, co", "las vegas, nv")

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq("Denver, CO")
    expect(trip.end_city).to eq("Las Vegas, NV")
    expect(trip.travel_time).to be_a String
    expect(trip.weather_at_eta).to be_a Hash
    expect(trip.weather_at_eta[:temperature]).to be_a Numeric
    expect(trip.weather_at_eta[:conditions]).to be_a String
  end

  it "can be an object with an impossible route" do
    trip = RoadTrip.new("denver, co", "tokyo, japan")

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq("Denver, CO")
    expect(trip.end_city).to eq("Tokyo, JP")
    expect(trip.travel_time).to eq("impossible route")
    expect(trip.weather_at_eta).to eq(nil)
  end

  describe 'instance methods' do
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

    it "formats the name of a starting city" do
      city_with_state = "denver, co"
      city_without_state = "tokyo, japan"
      trip = RoadTrip.new(city_with_state, city_without_state)

      expect(trip.format_start_city(city_with_state)).to eq("Denver, CO")
      expect(trip.format_start_city(city_without_state)).to eq("Tokyo, JP")
    end

    it "formats the name of an ending city" do
      city_with_state = "denver, co"
      city_without_state = "tokyo, japan"
      trip = RoadTrip.new(city_without_state, city_with_state)

      expect(trip.format_end_city(city_with_state)).to eq("Denver, CO")
      expect(trip.format_end_city(city_without_state)).to eq("Tokyo, JP")
    end
  end
end
