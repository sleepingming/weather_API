require 'rest-client'
require 'json'

class AccuWeatherClient

  URL = 'http://dataservice.accuweather.com/currentconditions/v1/294021/historical/24'

  def initialize(apikey)
    @apikey = apikey
  end

  def get_weather
    response = RestClient.get URL, { params: { apikey: @apikey }, content_type: :json, accept: :json }
    JSON.parse(response.body)
  end
end
