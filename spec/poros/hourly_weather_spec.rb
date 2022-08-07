require 'rails_helper'

RSpec.describe HourlyWeather do
  it "exists and has attributes" do
    hourly = {
      :dt=>1654988400,
      :temp=>95.97,
      :feels_like=>91.45,
      :pressure=>1002,
      :humidity=>14,
      :dew_point=>39.15,
      :uvi=>3.42,
      :clouds=>64,
      :visibility=>10000,
      :wind_speed=>6.08,
      :wind_deg=>225,
      :wind_gust=>11.59,
      :weather=>[{
        :id=>803,
        :main=>"Clouds",
        :description=>"broken clouds",
        :icon=>"04d"
        }],
      :pop=>0
    }

    hw = HourlyWeather.new(hourly)
    expect(hw).to be_a(HourlyWeather)
    expect(hw.temperature).to eq(95.97)
    expect(hw.conditions).to eq('broken clouds')
    expect(hw.icon).to eq('04d')
  end
end
