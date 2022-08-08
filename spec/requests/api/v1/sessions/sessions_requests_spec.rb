require 'rails_helper'

RSpec.describe 'Session Endpoint Requests' do
  describe 'happy path' do
    it "produces a response from POST sessions endpoint" do
      user_params = { "email": "test_2@email.com",
                      "password": "12345",
                      "password_confirmation": "12345" }
      post '/api/v1/users', params: user_params

      login_params = { "email": "test_2@email.com", "password": "12345" }
      post 'api/v1/sessions', params: login_params

      expect(response).to be_successful
    end
  end
end
