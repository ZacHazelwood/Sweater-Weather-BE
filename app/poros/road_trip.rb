class RoadTrip

  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = MapquestFacade.get_travel_time(origin, destination)
    @weather_at_eta = define_weather_at_eta(destination)
  end

  def define_weather_at_eta(destination)
    weather_at_eta_hash = Hash.new
    if @travel_time == "impossible route"
      weather_at_eta_hash = nil
    else
      weather_at_eta_hash[:temperature] = format_temp(destination)
      weather_at_eta_hash[:conditions] = format_conditions(destination)
    end
    weather_at_eta_hash
  end

  def format_temp(destination)
    destination_data = MapquestFacade.get_mapquest_location_data(destination)
    destination_forecast = OpenWeatherService.get_forecast_data(destination_data)
    hours = @travel_time.split(":")[0].to_i
    if hours > 48
      destination_forecast[:daily][( hours / 24 ).to_i][:temp][:day]
    else
      destination_forecast[:hourly][hours][:temp]
    end
  end

  def format_conditions(destination)
    destination_data = MapquestFacade.get_mapquest_location_data(destination)
    destination_forecast = OpenWeatherService.get_forecast_data(destination_data)
    hours = @travel_time.split(":")[0].to_i
    if hours > 48
      destination_forecast[:daily][( hours / 24 ).to_i][:weather][0][:description]
    else
      destination_forecast[:hourly][hours][:weather][0][:description]
    end
  end
end
