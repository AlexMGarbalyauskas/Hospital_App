# app/services/covid_vaccine_data_service.rb
class CovidVaccineDataService
  include HTTParty
  base_uri 'https://disease.sh/v3/covid-19/vaccine/coverage/countries'

  def fetch_vaccine_data
    self.class.get('', query: { lastdays: 1 })
  end
end
