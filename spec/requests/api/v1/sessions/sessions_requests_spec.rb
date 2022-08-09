require 'rails_helper'

RSpec.describe 'Session Endpoint Requests' do
  describe 'happy path' do
    it "produces a response from POST sessions endpoint" do
      user_params = { "email": "test_2@email.com",
                      "password": "12345",
                      "password_confirmation": "12345" }
      post '/api/v1/users', params: user_params

      login_params = { "email": "test_2@email.com", "password": "12345" }
      post '/api/v1/sessions', params: login_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :data
      expect(response_body[:data].keys).to eq([:id, :type, :attributes])

      response_data = response_body[:data]

      expect(response_data[:id]).to be_a String
      expect(response_data[:type]).to be_a String
      expect(response_data[:type]).to eq("users")
      expect(response_data[:attributes]).to be_a Hash

      response_attributes = response_data[:attributes]

      expect(response_attributes.keys).to eq([:email, :api_key])
      expect(response_attributes[:email]).to be_a String
      expect(response_attributes[:api_key]).to be_a String
    end
  end

  describe 'sad path' do
    it "sends an error 401 if user is not validated, unmatched password" do
      user_params = { "email": "test_2@email.com",
                      "password": "12345",
                      "password_confirmation": "12345" }
      post '/api/v1/users', params: user_params

      login_params = { "email": "test_2@email.com", "password": "11111" }
      post '/api/v1/sessions', params: login_params

      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Invalid credentials")
    end

    it "sends an error 401 if user is not validated, unmatched email" do
      user_params = { "email": "test_2@email.com",
                      "password": "12345",
                      "password_confirmation": "12345" }
      post '/api/v1/users', params: user_params

      login_params = { "email": "wrong@email.com", "password": "12345" }
      post '/api/v1/sessions', params: login_params

      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Invalid credentials")
    end

    it "sends an error 401 if user is not validated, missing email" do
      user_params = { "email": "test_2@email.com",
                      "password": "12345",
                      "password_confirmation": "12345" }
      post '/api/v1/users', params: user_params

      login_params = { "email": "", "password": "12345" }
      post '/api/v1/sessions', params: login_params

      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Missing field")
    end

    it "sends an error 401 if user is not validated, missing password" do
      user_params = { "email": "test_2@email.com",
                      "password": "12345",
                      "password_confirmation": "12345" }
      post '/api/v1/users', params: user_params

      login_params = { "email": "test_2@email.com", "password": "" }
      post '/api/v1/sessions', params: login_params

      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq("Missing field")
    end
  end
end
