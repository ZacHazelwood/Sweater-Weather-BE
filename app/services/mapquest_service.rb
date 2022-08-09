class MapquestService
  def self.get_location_data(location)
    end_point = '/geocoding/v1/address'
    response = conn.get(end_point) do |faraday|
      faraday.params['key'] = ENV['mapquest_api_key']
      faraday.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    url = 'http://www.mapquestapi.com'
    Faraday.new(url: url)
  end

  def self.get_directions_data(from, to)
    end_point = '/directions/v2/route'
    response = conn.get(end_point) do |faraday|
      faraday.params['from'] = from
      faraday.params['to'] = to
      faraday.params['key'] = ENV['mapquest_api_key']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
