class WeatherAPI < Grape::API
  format :json
  helpers do
    def weather_for_last_24h
      WeatherForecast.where('date >= ? and date <= ?', Time.now.to_i - (24 * 60 * 60), Time.now.to_i)
      WeatherForecast.order('date DESC').take(24)
    end
  end
  resource :weather do
    desc 'Returns current temperature'
    get :current do
      WeatherForecastsRepresenter.new(WeatherForecast.order('date DESC').first).as_json
    end

    desc 'Returns historical temperature for last 24 hours'
    get :historical do
      WeatherForecastsRepresenter.new(weather_for_last_24h).as_json
    end

    desc 'Returns max temperature for last 24 hours'
    get :max do
      WeatherForecastsRepresenter.new(weather_for_last_24h.first).as_json
    end

    desc 'Returns min temperature for last 24 hours'
    get :min do
      WeatherForecastsRepresenter.new(weather_for_last_24h.last).as_json
    end

    desc 'Returns average temperature for last 24 hours'
    get :avg do
      WeatherForecast.order('date DESC').average(:temperature).to_f
    end

    params do
      requires :time, type: Integer
    end
    get :by_time do
      if params[:time].blank?
        status 404
      else
        WeatherForecastsRepresenter.new(WeatherForecast.find_by_sql ["select * from weather_forecasts order by abs(date - ?) limit 1", params[:time]]).as_json
      end
    end

    get :health do
      status 200
    end
  end
end
