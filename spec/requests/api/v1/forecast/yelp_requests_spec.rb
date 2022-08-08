require 'rails_helper'

RSpec.describe 'Yelp Requests' do
  it "completes a request" do
    get '/api/v1/munchies?location=denver,co&food=asian'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq 200

    expect(response_body[:data].keys).to eq([:id, :type, :attributes])
    expect(response_body[:data][:id]).to eq "null"
    expect(response_body[:data][:type]).to eq "munchie"

    expect(response_body[:data][:attributes].keys).to eq([:destination_city, :forecast, :restaurant])
    expect(response_body[:data][:attributes][:destination_city]).to be_a String
    expect(response_body[:data][:attributes][:forecast]).to be_a Hash
    expect(response_body[:data][:attributes][:restaurant]).to be_a Hash

    expect(response_body[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
    expect(response_body[:data][:attributes][:forecast]).to_not have_key(:wind_speed)
    expect(response_body[:data][:attributes][:forecast][:summary]).to be_a String
    expect(response_body[:data][:attributes][:forecast][:temperature]).to be_a String

    expect(response_body[:data][:attributes][:restaurant].keys).to eq([:name, :address])
    expect(response_body[:data][:attributes][:restaurant]).to_not have_key(:review_count)
    expect(response_body[:data][:attributes][:restaurant][:name]).to be_a String
    expect(response_body[:data][:attributes][:restaurant][:address]).to be_a String
  end
end
