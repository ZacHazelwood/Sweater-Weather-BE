require 'rails_helper'

RSpec.describe DailyWeather do
  it "exists and has attributes" do
    daily = {
          :dt=>1654970400,
          :sunrise=>1654947095,
          :sunset=>1655000870,
          :moonrise=>1654990200,
          :moonset=>1654939140,
          :moon_phase=>0.39,
          :temp=>{
            :day=>94.48,
            :min=>69.33,
            :max=>97.74,
            :night=>77.72,
            :eve=>95.45,
            :morn=>69.33
          },
          :feels_like=>{
            :day=>89.78,
            :night=>76.46,
            :eve=>91.22,
            :morn=>67.42
          },
          :pressure=>1004,
          :humidity=>11,
          :dew_point=>32.2,
          :wind_speed=>16.91,
          :wind_deg=>179,
          :wind_gust=>21.27,
          :weather=>[{
            :id=>800,
            :main=>"Clear",
            :description=>"clear sky",
            :icon=>"01d"
            }],
          :clouds=>5,
          :pop=>0.08,
          :uvi=>10.66
        }

    dw = DailyWeather.new(daily)

    expect(dw).to be_a(DailyWeather)
    expect(dw.date).to eq('2022-06-11')
    expect(dw.sunrise).to eq('2022-06-11 07:31:35 -0400')
    expect(dw.sunset).to eq('2022-06-11 22:27:50 -0400')
    expect(dw.max_temp).to eq(97.74)
    expect(dw.min_temp).to eq(69.33)
    expect(dw.conditions).to eq('clear sky')
    expect(dw.icon).to eq('01d')
  end
end
