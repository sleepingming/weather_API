require 'rails_helper'

RSpec.describe WeatherForecast, type: :model do
  it { should validate_presence_of :date }
  it { should validate_presence_of :temperature }
end
