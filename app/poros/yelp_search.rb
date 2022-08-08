class YelpSearch

  attr_reader :id, :destination_city, :forecast, :restaurant

  def initialize(location, weather, business)
    @id = "null"
    @destination_city = location
    @forecast = { summary: weather[:conditions], temperature: weather[:temperature] }
    @restaurant = {name: business[:name], address: business[:address]}
  end
end
