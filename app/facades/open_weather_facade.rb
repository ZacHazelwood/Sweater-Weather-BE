class OpenWeatherFacade

  def self.create_forecast_results(location)
    json = OpenWeatherService.get_forecast_data(location)
    forecast = Hash.new
    forecast[:current_weather] = CurrentWeather.new(json[:current])
    forecast[:daily_weather] = json[:daily].map { |day| DailyWeather.new(day) }
    forecast[:hourly_weather] = json[:hourly].map { |hour| HourlyWeather.new(hour) }
    Forecast.new(forecast)
  end
end
