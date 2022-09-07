class WeatherForecast < ApplicationRecord
  validates :temperature, :date, presence: true
end
