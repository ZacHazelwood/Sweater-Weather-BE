class MapquestFacade
  def self.get_mapquest_location_data(location)
    json = MapquestService.get_location_data(location)
    result = json[:results][0][:locations][0]
    MapquestLocation.new(result)
  end
end
