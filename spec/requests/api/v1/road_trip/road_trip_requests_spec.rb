require 'rails_helper'

RSpec.describe "Road Trip Requests" do
  describe 'happy path' do
    it "reutrns a roadtrip from valid credentials" do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "Denver, CO",
               "destination": "Santa Fe, CA",
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to be_successful
      expect(response.status).to eq 200
    end
  end
end
