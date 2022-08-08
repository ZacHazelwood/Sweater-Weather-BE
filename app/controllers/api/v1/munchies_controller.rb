class Api::V1::MunchiesController < ApplicationController
  def index
    business = YelpFacade.create_yelp_results(search_params)

    render json: MunchieSerializer.new(business)
  end

  private
    def search_params
      params.permit(:location, :food)
    end
end
