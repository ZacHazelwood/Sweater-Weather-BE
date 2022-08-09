class RoadTripFacade

  def self.create_road_trip(from, to)
    travel_time = MapquestFacade.get_travel_time(from, to)

    RoadTrip.new(from, to)
  end
end
