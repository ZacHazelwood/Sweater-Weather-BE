require 'rails_helper'

RSpec.describe MapquestFacade do
  describe 'happy path' do
    it "creates location object" do
      location = MapquestFacade.get_mapquest_location_data('denver, co')

      expect(location).to be_a MapquestLocation
      expect(location.latitude).to eq(39.738453)
      expect(location.longitude).to eq(-104.984853)
    end

    it "gets the travel time between two locations" do
      travel_time = MapquestFacade.get_travel_time("denver, co", "boulder, co")

      expect(travel_time).to be_a String
    end
  end

  describe 'sad path' do
    it "cannot provide time of an impossible route" do
      travel_time = MapquestFacade.get_travel_time("sarasota, fl", "london, england")

      expect(travel_time).to be_a String
      expect(travel_time).to eq("impossible route")
    end
  end
end
