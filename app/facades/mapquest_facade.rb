class MapquestFacade
  def self.get_mapquest_location_data(location)
    json = MapquestService.get_location_data(location)
    result = json[:results][0][:locations][0][:latLng]
    MapquestLocation.new(result)
  end

  def self.get_travel_time(from, to)
    directions_json = MapquestService.get_directions_data(from, to)
    if directions_json[:info][:messages].include?("We are unable to route with the given locations.")
      "impossible route"
    else
      directions_json[:route][:formattedTime]
    end
  end
end
