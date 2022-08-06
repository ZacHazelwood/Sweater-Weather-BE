require 'rails_helper'

RSpec.describe MapQuestLocationService do
  it "establishes a connection" do
    conn = MapQuestService.conn

    expect(conn.class).to eq(Faraday::Connection)
  end

  it "sends a response" do
    response = MapQuestService.get_location_data("denver, co")

    expect(response).to be_a Hash
  end
end
