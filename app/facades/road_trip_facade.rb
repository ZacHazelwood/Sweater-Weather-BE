class RoadTripFacade

  def self.create_road_trip(origin, destination)
    travel_time = MapquestFacade.get_travel_time(origin, destination)

    RoadTrip.new(origin, destination)
  end
end
