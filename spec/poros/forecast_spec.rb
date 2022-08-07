require 'rails_helper'

RSpec.describe Forecast do
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

    cw = CurrentWeather.new(current)
    dw = [DailyWeather.new(daily)]
    hw = [HourlyWeather.new(hourly)]
    forecast = Forecast.new({ current_weather: cw,
                              daily_weather: dw,
                              hourly_weather: hw })

    expect(forecast).to be_a Forecast
    expect(forecast.id).to eq("null")
    expect(forecast.type).to eq("forecast")
    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.daily_weather[0]).to be_a DailyWeather
    expect(forecast.hourly_weather[0]).to be_a HourlyWeather
  end
end
