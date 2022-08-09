class Api::V1::RoadTripController < ApplicationController
  before_action :verify, :check_fields

  def create
    trip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(trip), status: 200
  end

  private

    def verify
      unless User.find_by(api_key: params[:api_key])
        render json: { error: 'Invalid or Missing Key' }, status: 401
      end
    end

    def check_fields
      if params[:origin] == "" || params[:destination] == ""
        render json: { error: 'Missing Field' }, status: 401
      elsif params[:origin].nil? || params[:destination].nil?
        render json: { error: 'Missing Field' }, status: 401
      end
    end
end
