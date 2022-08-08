require 'rails_helper'

RSpec.describe YelpService do
  it "exists and has attributes" do
    location = 'denver,co'
    weather = {:conditions=>"clear sky", :temperature=>"89 F"}
    business = {name: "Food Place", address: "Street" }

    yelp = YelpSearch.new(location, weather, business)

    expect(yelp).to be_a YelpSearch
    expect(yelp.id).to eq "null"
    expect(yelp.destination_city).to eq ("denver,co")
    expect(yelp.forecast).to eq({:summary=>"clear sky", :temperature=>"89 F"})
    expect(yelp.restaurant).to eq({name: "Food Place", address: "Street" })
  end
end
