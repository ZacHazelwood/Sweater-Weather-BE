require 'rails_helper'

RSpec.describe 'User Requests' do
  describe 'happy path' do
    it "creates a user through a POST request" do
      user = { "email": "test_1@email.com",
               "password": '12345',
               "password_confirmation": '12345' }
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/users', headers: headers, params: user

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :data
    end
  end
end
