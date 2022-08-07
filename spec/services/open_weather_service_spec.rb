require 'rails_helper'

RSpec.describe OpenWeatherService do
  it "establishes a connection" do
    conn = OpenWeatherService.conn

    expect(conn.class).to eq(Faraday::Connection)
  end

  it 'gets forecast data from a MapQuest location' do
    data = {  lat: 39.738453, lng: -104.984853 }
    location = MapquestLocation.new(data)
require "pry"; binding.pry
    expect(OpenWeatherService.get_forecast_data(location)).to be_a Hash
  end
end
