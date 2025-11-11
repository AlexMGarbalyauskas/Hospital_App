# app/services/global_covid_service.rb
class GlobalCovidService
  require 'net/http'
  require 'json'

  API_URL = "https://disease.sh/v3/covid-19/all"

  def fetch
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error "GlobalCovidService Error: #{e.message}"
    {}
  end
end
