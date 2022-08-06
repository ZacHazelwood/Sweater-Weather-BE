require 'rails_helper'

RSpec.describe MapquestService do
  it "establishes a connection" do
    conn = MapquestService.conn

    expect(conn.class).to eq(Faraday::Connection)
  end

  it "sends a response" do
    response = MapquestService.get_location_data("denver, co")

    expect(response).to be_a Hash
  end
end
