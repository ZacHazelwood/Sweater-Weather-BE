class Api::V1::ForecastController < ApplicationController
  def index
    location = MapquestFacade.get_mapquest_location_data(forecast_params)
    forecast = OpenWeatherFacade.create_forecast_results(location)

    render json: ForecastSerializer.new(forecast)
  end

  private
    def forecast_params
      params.permit(:location)
    end
end
