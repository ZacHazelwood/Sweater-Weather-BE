require 'rails_helper'

RSpec.describe YelpService do
  it "establishes a connection" do
    conn = YelpService.conn

    expect(conn.class).to eq(Faraday::Connection)
  end

  it "gets results from an endpoint" do
    data = {  lat: 39.738453, lng: -104.984853 }
    location = MapquestLocation.new(data)
    term = "asain"

    expect(YelpService.get_business_data(location, term)).to be_a Hash
  end
end
