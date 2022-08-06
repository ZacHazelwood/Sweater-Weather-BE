class MapquestLocation
  attr_reader :latitude,
              :longitude

  def initialize(data)
    @latitude   = data[0][:latLng][:lat]
    @longitude   = data[0][:latLng][:lng]
  end
end
