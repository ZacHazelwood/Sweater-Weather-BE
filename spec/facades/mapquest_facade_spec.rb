require 'rails_helper'

RSpec.describe MapquestFacade do
  it "gets location data" do
    location = MapquestFacade.get_mapquest_location_data('denver, co')

    expect(location).to be_a MapquestLocation
    expect(location.latitude).to eq(39.738453)
    expect(location.longitude).to eq(-104.984853)
  end
end
