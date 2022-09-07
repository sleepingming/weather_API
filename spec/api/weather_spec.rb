require 'rails_helper'

RSpec.describe Weather do
  include Rack::Test::Methods

  context 'GET /weather/current' do
    before do
      create(:weather_forecast, temperature: 10, date: 1621823790)
      create(:weather_forecast, temperature: 5, date: 1621823789)
    end
    it 'returns current temperature' do
      get '/weather/current'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({ "date"=>1621823790, "temperature"=>10.0 })
    end
  end

  context 'GET /weather/historical' do
    before { create_list(:weather_forecast, 24) }
    it 'returns temperature for last 24 hours' do
      get '/weather/historical'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).size).to eq(24)
    end
  end

  context 'GET /weather/max' do
    before do
      create(:weather_forecast, temperature: 10, date: 1621823790)
      create(:weather_forecast, temperature: 5, date: 1621823789)
    end
    it 'returns max temperature for last 24 hours' do
      get '/weather/max'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({ "date"=>1621823790, "temperature"=>10.0 })
    end
  end

  context 'GET /weather/min' do
    before do
      create(:weather_forecast, temperature: 10, date: 1621823790)
      create(:weather_forecast, temperature: 5, date: 1621823789)
    end
    it 'returns min temperature for last 24 hours' do
      get '/weather/min'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({ "date"=>1621823789, "temperature"=>5.0 })
    end
  end

  context 'GET /weather/avg' do
    before do
      create(:weather_forecast, temperature: 10, date: 1621823790)
      create(:weather_forecast, temperature: 10, date: 1621823789)
    end
    it 'returns min temperature for last 24 hours' do
      get '/weather/avg'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq(10.0)
    end
  end

  context 'GET /weather/by_time' do
    before do
      create(:weather_forecast, temperature: 10, date: 1621823790)
      create(:weather_forecast, temperature: 4, date: 1621824290)
    end
    it 'returns min temperature for last 24 hours' do
      get "/weather/by_time?time=#{WeatherForecast.first.date + 1}"
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)[0]).to eq({ "date"=>1621823790, "temperature"=>10.0 })
    end
  end

  context 'GET /weather/health' do
    it 'returns status 200' do
      get '/weather/health'
      expect(last_response.status).to eq(200)
    end
  end
end
