class Api::V1::ForecastController < ApplicationController
  def index
    if forecast_params[:location]
      location = MapquestFacade.get_mapquest_location_data(forecast_params)
      forecast = OpenWeatherFacade.create_forecast_results(location)

      render json: ForecastSerializer.new(forecast)
    else
      render json: { status: "Not Found", code: 400, message: "Please enter a location" }, status: 400
    end
  end

  private
    def forecast_params
      params.permit(:location)
    end
end
