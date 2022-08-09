class OpenWeatherService
  def self.conn
    url = 'https://api.openweathermap.org'
    Faraday.new(url: url)
  end

  def self.get_forecast_data(location)
    end_point = '/data/2.5/onecall'
    response = conn.get(end_point) do |f|
      f.params['lat'] = location.latitude
      f.params['lon'] = location.longitude
      f.params['exclude'] = 'minutely'
      f.params['units'] = 'imperial'
      f.params['appid'] = ENV['openweather_api_key']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
