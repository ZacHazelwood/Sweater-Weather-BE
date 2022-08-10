require 'rails_helper'

RSpec.describe MapquestService do
  it "establishes a connection" do
    conn = MapquestService.conn

    expect(conn.class).to eq(Faraday::Connection)
  end

  it "sends a response", :vcr do
    response = MapquestService.get_location_data("denver, co")

    expect(response).to be_a Hash

    expect(response).to have_key(:results)
    expect(response[:results].first).to have_key(:locations)
    expect(response[:results].first[:locations].first).to have_key(:latLng)
  end

  it "connects to MapQuest directions", :vcr do
    response = MapquestService.get_directions_data("denver,co", "boulder,co")

    expect(response).to be_a Hash

    expect(response).to have_key :route
    expect(response[:route]).to have_key :formattedTime
  end
end
