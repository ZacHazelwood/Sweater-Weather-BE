class YelpService

  def self.conn
    url = 'https://api.yelp.com'
    Faraday.new(url: url)
  end

  def self.get_business_data(location, term)
    end_point = '/v3/businesses/search'
    response = conn.get(end_point) do |f|
      f.params['location'] = "#{location.latitude},#{location.longitude}"
      f.params['term'] = term
      f.headers['Authorization'] = 'Bearer NPc1q-XyjespyxU_3FIwyV7J-eDIYLtNcgUaYQKHfRSammf8Jmqc5bE_opeLHfkN2yVrXJz-Cq8bf2kVCpJd-wusKWzGxSpJoigLqlwv2uarr6cUxrlc3WhEZiXxYnYx'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
