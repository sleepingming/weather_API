class WeatherForecastsRepresenter
  def initialize(weather_forecasts)
    @weather_forecasts = weather_forecasts
  end

  def as_json
    if @weather_forecasts.instance_of?(Array)
      @weather_forecasts.map do |weather_forecast|
        {
          date: weather_forecast.date,
          temperature: weather_forecast.temperature
        }
      end
    else
      {
        date: @weather_forecasts.date,
        temperature: @weather_forecasts.temperature
      }
    end
  end

  private

  attr_reader :weather_forecasts
end
