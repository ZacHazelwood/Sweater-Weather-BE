require 'rails_helper'

RSpec.describe 'forecast endpoints' do
  it "connects to the index endpoint", :vcr do
    get '/api/v1/forecast?location=denver,co'

    response_body = JSON.parse(response.body, symbolize_names: true)
    forecast = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(forecast).to have_key :id
    expect(forecast[:id]).to eq("null")
    expect(forecast).to have_key :type
    expect(forecast[:type]).to eq("forecast")
    expect(forecast).to have_key :attributes
    expect(forecast[:attributes]).to be_a Hash

    attributes = forecast[:attributes]

      expect(attributes.keys).to eq([:current_weather, :daily_weather, :hourly_weather])

    current_weather = attributes[:current_weather]

      expect(current_weather.keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather[:temperature]).to be_a Numeric
      expect(current_weather[:feels_like]).to be_a Numeric
      expect(current_weather[:humidity]).to be_a Numeric
      expect(current_weather[:uvi]).to be_a Numeric
      expect(current_weather[:visibility]).to be_a Numeric
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather[:icon]).to be_a String

      expect(current_weather).to_not have_key :clouds
      expect(current_weather).to_not have_key :wind_speed

    hourly_weather = attributes[:hourly_weather]

      hourly_weather.each do |hour|
        expect(hour.keys).to eq([:time, :temperature, :conditions, :icon])
        expect(hour[:time]).to be_a String
        expect(hour[:temperature]).to be_a Numeric
        expect(hour[:conditions]).to be_a String
        expect(hour[:icon]).to be_a String

        expect(hour).to_not have_key :visibility
        expect(hour).to_not have_key :wind_speed
      end

    daily_weather = attributes[:daily_weather]

      daily_weather.each do |day|
        expect(day.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
        expect(day[:date]).to be_a String
        expect(day[:sunrise]).to be_a String
        expect(day[:sunset]).to be_a String
        expect(day[:max_temp]).to be_a Numeric
        expect(day[:min_temp]).to be_a Numeric
        expect(day[:conditions]).to be_a String
        expect(day[:icon]).to be_a String

        expect(day).to_not have_key :moon_phase
        expect(day).to_not have_key :feels_like
      end
  end

  it "sends an error if no location is searched" do
    get '/api/v1/forecast'

    expect(response.status).to eq 400
    expect(response.body).to eq("{\"status\":\"Not Found\",\"code\":400,\"message\":\"Please enter a location\"}")
  end
end
