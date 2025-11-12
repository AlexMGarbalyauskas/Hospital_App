# app/services/covid_vaccine_data_service.rb

# Service to fetch and process COVID-19 vaccine data
class CovidVaccineDataService

  # gem used to make HTTP requests
  include HTTParty

  # setting the base URI for the API
  base_uri 'https://disease.sh/v3/covid-19/vaccine/coverage/countries'

  # service method to fetch vaccine data for all countries
  def fetch_vaccine_data
    self.class.get('', query: { lastdays: 1 })
  end

  
end
