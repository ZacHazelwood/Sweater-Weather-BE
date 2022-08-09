class RoadTrip

  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination)
    @id = nil
    @start_city = format_start_city(origin)
    @end_city = format_end_city(destination)
    @travel_time = format_travel_time(origin, destination)
    @weather_at_eta = define_weather_at_eta(origin, destination)
  end

  def define_weather_at_eta(origin, destination)
    weather_at_eta_hash = Hash.new
    if @travel_time == "impossible route"
      weather_at_eta_hash = nil
    else
      weather_at_eta_hash[:temperature] = format_temp(origin, destination)
      weather_at_eta_hash[:conditions] = format_conditions(origin, destination)
    end
    weather_at_eta_hash
  end

  def format_temp(origin, destination)
    destination_data = MapquestFacade.get_mapquest_location_data(destination)
    destination_forecast = OpenWeatherService.get_forecast_data(destination_data)
    unformatted_time = MapquestFacade.get_travel_time(origin, destination)
    hours = unformatted_time.split(":")[0].to_i
    if hours > 48
      destination_forecast[:daily][( hours / 24 ).to_i][:temp][:day]
    else
      destination_forecast[:hourly][hours][:temp]
    end
  end

  def format_conditions(origin, destination)
    destination_data = MapquestFacade.get_mapquest_location_data(destination)
    destination_forecast = OpenWeatherService.get_forecast_data(destination_data)
    unformatted_time = MapquestFacade.get_travel_time(origin, destination)
    hours = unformatted_time.split(":")[0].to_i
    if hours > 48
      destination_forecast[:daily][( hours / 24 ).to_i][:weather][0][:description]
    else
      destination_forecast[:hourly][hours][:weather][0][:description]
    end
  end

  def format_start_city(origin)
    place = MapquestService.get_location_data(origin)[:results][0][:locations][0]
    if place[:adminArea3] != ""
      format = "#{place[:adminArea5]}, #{place[:adminArea3]}"
    else
      format = "#{place[:adminArea5]}, #{place[:adminArea1]}"
    end
    format
  end

  def format_end_city(destination)
    place = MapquestService.get_location_data(destination)[:results][0][:locations][0]
    if place[:adminArea3] != ""
      format = "#{place[:adminArea5]}, #{place[:adminArea3]}"
    else
      format = "#{place[:adminArea5]}, #{place[:adminArea1]}"
    end
    format
  end

  def format_travel_time(origin, destination)
    travel_time = ""
    unformatted_time = MapquestFacade.get_travel_time(origin, destination)
    if unformatted_time == "impossible route"
      return unformatted_time
    else
      route_time = unformatted_time.split(":").map { |time| time.to_i }
      if route_time[0] < 24
        travel_time = "#{route_time[0]} hour(s), #{route_time[1]} minute(s)"
      else
        travel_time = "#{(route_time[0] / 24)} day(s), #{(route_time[0] % 24)} hour(s), #{route_time[1]} minute(s)"
      end
    end
    return travel_time
  end
end
