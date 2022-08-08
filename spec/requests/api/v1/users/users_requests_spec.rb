require 'rails_helper'

RSpec.describe 'User Requests' do
  describe 'happy path' do
    it "creates a user through a POST request" do
      user = { "email": "test_2@email.com",
               "password": "12345",
               "password_confirmation": "12345" }
      post '/api/v1/users', params: user

      expect(response).to be_successful
      expect(response.status).to eq 201

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :data
      expect(response_body[:data].keys).to eq([:id, :type, :attributes])

      user_data = response_body[:data]

      expect(user_data[:id]).to be_a String
      expect(user_data[:type]).to be_a String
      expect(user_data[:type]).to eq("users")

      user_attributes = user_data[:attributes]

      expect(user_attributes.keys).to eq([:email, :api_key])
      expect(user_attributes[:email]).to be_a String
      expect(user_attributes[:email]).to eq("test_2@email.com")
      expect(user_attributes[:api_key]).to be_a String

      expect(User.find_by(email: 'test_2@email.com')).to be_a User
      expect(User.find_by(email: 'test_2@email.com').authenticate("12345")).to be_a User
    end
  end

  describe 'sad path' do
    it "must have matching passwords" do
      user = { "email": "test_3@email.com",
               "password": "12345",
               "password_confirmation": "11111" }
      post '/api/v1/users', params: user

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Passwords must match")
    end

    it "cannot create a user when email in use" do
      # User already exists with this email
      user = { "email": "test_1@email.com",
               "password": "12345",
               "password_confirmation": "12345" }
      post '/api/v1/users', params: user

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Email is unavailable")
    end

    it "cannot create a user with missing fields, email" do
      user = { "email": "",
               "password": "12345",
               "password_confirmation": "12345" }
      post '/api/v1/users', params: user

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Missing Field")
    end

    it "cannot create a user with missing fields, password" do
      user_1 = { "email": "test_4@email.com",
               "password": "",
               "password_confirmation": "12345" }
      post '/api/v1/users', params: user_1

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Missing Field")

      user_2 = { "email": "test_4@email.com",
               "password": "12345",
               "password_confirmation": "" }
      post '/api/v1/users', params: user_2

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Missing Field")

      user_3 = { "email": "test_4@email.com",
               "password": "",
               "password_confirmation": "" }
      post '/api/v1/users', params: user_3

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 401
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Missing Field")
    end
  end
end
