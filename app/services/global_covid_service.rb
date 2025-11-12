# app/services/global_covid_service.rb

# Service to fetch global COVID-19 data
class GlobalCovidService
  require 'net/http'
  require 'json'

  # url for global COVID-19 data
  API_URL = "https://disease.sh/v3/covid-19/all"

  # service method to fetch global COVID-19 data
  def fetch
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error "GlobalCovidService Error: #{e.message}"
    {}
  end
end #end
