require 'rails_helper'

RSpec.describe "Road Trip Requests" do
  describe 'happy path' do
    it "reutrns a roadtrip from valid credentials", :vcr do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "Denver, CO",
               "destination": "Santa Barbara, CA",
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to be_successful
      expect(response.status).to eq 200

      response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a Hash
        expect(response_body).to have_key :data
        expect(response_body[:data]).to be_a Hash

      response_data = response_body[:data]

        expect(response_data.keys).to eq([:id, :type, :attributes])
        expect(response_data[:id]).to eq nil
        expect(response_data[:type]).to be_a String
        expect(response_data[:type]).to eq("road_trip")

      attributes = response_data[:attributes]

        expect(attributes).to be_a Hash
        expect(attributes.keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(attributes).to have_key :start_city
        expect(attributes[:start_city]).to be_a String

        expect(attributes).to have_key :end_city
        expect(attributes[:end_city]).to be_a String

        expect(attributes).to have_key :travel_time
        expect(attributes[:travel_time]).to be_a String

        expect(attributes).to have_key :weather_at_eta
        expect(attributes[:weather_at_eta]).to be_a Hash

        expect(attributes[:weather_at_eta]).to have_key :temperature
        expect(attributes[:weather_at_eta][:temperature]).to be_a Numeric
        expect(attributes[:weather_at_eta]).to have_key :conditions
        expect(attributes[:weather_at_eta][:conditions]).to be_a String

      expect(attributes).to_not have_key :wind_speed
      expect(attributes).to_not have_key :moon_rise
    end

    it "reutrns a roadtrip from with an impossible route", :vcr do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "Denver, CO",
               "destination": "Tokyo, Japan",
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to be_successful
      expect(response.status).to eq 200

      response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a Hash
        expect(response_body).to have_key :data
        expect(response_body[:data]).to be_a Hash

      response_data = response_body[:data]

        expect(response_data.keys).to eq([:id, :type, :attributes])
        expect(response_data[:id]).to eq nil
        expect(response_data[:type]).to be_a String
        expect(response_data[:type]).to eq("road_trip")

      attributes = response_data[:attributes]

        expect(attributes).to be_a Hash
        expect(attributes.keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(attributes).to have_key :start_city
        expect(attributes[:start_city]).to be_a String

        expect(attributes).to have_key :end_city
        expect(attributes[:end_city]).to be_a String

        expect(attributes).to have_key :travel_time
        expect(attributes[:travel_time]).to be_a String
        expect(attributes[:travel_time]).to eq ("impossible route")

        expect(attributes).to have_key :weather_at_eta
        expect(attributes[:weather_at_eta]).to eq nil

      expect(attributes).to_not have_key :wind_speed
      expect(attributes).to_not have_key :moon_rise
    end
  end

  describe 'sad path' do
    it "sends an error when api key not present or incorrect" do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "Denver, CO",
               "destination": "Santa Barbara, CA",
               "api_key": "wrong key baybee" }

      post '/api/v1/road_trip', params: data

      expect(response).to_not be_successful
      expect(response.status).to eq 401

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Invalid or Missing Key")
    end

    it "sends an error when origin is not entered" do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "",
               "destination": "Santa Barbara, CA",
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to_not be_successful
      expect(response.status).to eq 401

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Missing Field")
    end

    it "sends an error when origin nil" do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": nil,
               "destination": "Santa Barbara, CA",
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to_not be_successful
      expect(response.status).to eq 401

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Missing Field")
    end

    it "sends an error when destination is not entered" do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "Denver, CO",
               "destination": "",
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to_not be_successful
      expect(response.status).to eq 401

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Missing Field")
    end

    it "sends an error when destination nil" do
      user_data = { "email": "email@email.com",
                    "password": "12345",
                    "password_confirmation": "12345" }
      post '/api/v1/users', params: user_data

      user_response_body = JSON.parse(response.body, symbolize_names: true)
      api_key = user_response_body[:data][:attributes][:api_key]

      data = { "origin": "Denver, CO",
               "destination": nil,
               "api_key": api_key }

      post '/api/v1/road_trip', params: data

      expect(response).to_not be_successful
      expect(response.status).to eq 401

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Missing Field")
    end
  end
end
