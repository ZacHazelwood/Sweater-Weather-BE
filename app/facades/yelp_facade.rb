class YelpFacade

  def self.create_yelp_results(params)
    location = MapquestFacade.get_mapquest_location_data(params[:location])
    forecast = OpenWeatherFacade.create_forecast_results(location)
    forecast_data = { conditions: forecast.current_weather.conditions, temperature: (forecast.current_weather.temperature.to_i.to_s + " F") }
    yelp_search = YelpService.get_business_data(location, params[:food])
    business = { name: yelp_search[:businesses][0][:name], address: yelp_search[:businesses][0][:location][:display_address].join(", ") }
    YelpSearch.new(params[:location], forecast_data, business)
  end
end
