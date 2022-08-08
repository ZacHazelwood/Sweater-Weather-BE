require 'rails_helper'

RSpec.describe YelpFacade do
  it "creates business result objects" do
    location_city = "denver,co"
    data = {  lat: 39.738453, lng: -104.984853 }
    location = MapquestLocation.new(data)
    forecast = OpenWeatherFacade.create_forecast_results(location)
    params = {location: location_city, forecast: forecast, term: "asian"}

    yelp = YelpFacade.create_yelp_results(params)

    expect(yelp).to be_a YelpSearch
  end
end
