class RoadTrip

  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(from, to)
    @id = nil
    @start_city = from
    @end_city = to
    @travel_time = MapquestFacade.get_travel_time(from, to)
    @weather_at_eta = define_weather_at_eta(from, to)
  end

  def define_weather_at_eta(from, to)
    if @travel_time == "impossible route"
      nil
    else
      # methods to get temp and conditions
    end
  end
end
