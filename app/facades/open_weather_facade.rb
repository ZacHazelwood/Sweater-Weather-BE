class OpenWeatherFacade

  def self.create_forecast_results(location)
    json = OpenWeatherService.get_forecast_data(location)
    forecast = Hash.new
    forecast[:current_weather] = CurrentWeather.new(json[:current])
    forecast[:daily_weather] = json[:daily][0..4].map { |day| DailyWeather.new(day) }
    forecast[:hourly_weather] = json[:hourly][0..7].map { |hour| HourlyWeather.new(hour) }
    Forecast.new(forecast)
  end
end
