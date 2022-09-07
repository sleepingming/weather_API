class GetWeatherDataService

  def call
    client = AccuWeatherClient.new(Rails.application.credentials.accu_weather_key)
    client.get_weather.each do |data|
      WeatherForecast.where(date: data['EpochTime']).first_or_create(temperature: data.dig('Temperature', 'Metric', 'Value'))
    end
  end
end
