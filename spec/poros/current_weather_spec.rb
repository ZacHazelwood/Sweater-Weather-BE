require 'rails_helper'

RSpec.describe CurrentWeather do
  it "exists and has attributes" do
    current = {
      :dt=>1654991578,
      :sunrise=>1654947095,
      :sunset=>1655000870,
      :temp=>95.45,
      :feels_like=>91.22,
      :pressure=>1003,
      :humidity=>16,
      :dew_point=>42.17,
      :uvi=>1.57,
      :clouds=>65,
      :visibility=>10000,
      :wind_speed=>1.01,
      :wind_deg=>198,
      :weather=>[{
        :id=>803,
        :main=>"Clouds",
        :description=>"broken clouds",
        :icon=>"04d"
        }]
      }

    cw = CurrentWeather.new(current)

    expect(cw).to be_a CurrentWeather

    expect(cw.datetime).to eq('2022-06-11 19:52:58 -0400')
    expect(cw.sunrise).to eq('2022-06-11 07:31:35 -0400')
    expect(cw.sunset).to eq('2022-06-11 22:27:50 -0400')
    expect(cw.temperature).to eq(95.45)
    expect(cw.feels_like).to eq(91.22)
    expect(cw.humidity).to eq(16)
    expect(cw.uvi).to eq(1.57)
    expect(cw.visibility).to eq(10000)
    expect(cw.conditions).to eq('broken clouds')
    expect(cw.icon).to eq('04d')
  end
end
