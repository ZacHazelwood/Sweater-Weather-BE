require 'rails_helper'

RSpec.describe OpenWeatherFacade do
  it "creates forecast results from a location" do
    data = {  lat: 39.738453, lng: -104.984853 }
    location = MapquestLocation.new(data)

    results = OpenWeatherFacade.create_forecast_results(location)

    expect(results).to be_a Forecast
    expect(results.current_weather).to be_a CurrentWeather
    expect(results.daily_weather).to be_all DailyWeather
    expect(results.hourly_weather).to be_all HourlyWeather
  end
end
