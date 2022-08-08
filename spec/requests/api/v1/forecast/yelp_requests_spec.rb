require 'rails_helper'

RSpec.describe 'Yelp Requests' do
  it "completes a request" do
    get '/api/v1/munchies?location=denver,co&food=asian'
# require "pry"; binding.pry
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end
end
