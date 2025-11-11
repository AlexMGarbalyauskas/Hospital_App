# app/services/covid_historical_data_service.rb
class CovidHistoricalDataService
  include HTTParty
  base_uri 'https://disease.sh/v3/covid-19/historical/all'

  def fetch_all
    response = self.class.get("?lastdays=all")

    return { raw: {}, daily_new_cases: [] } unless response.success?

    data = response.parsed_response
    previous_total = nil

    daily_new_cases = data['cases'].map do |date_str, total|
      date = Date.strptime(date_str, "%m/%d/%y")
      if previous_total
        new_cases = total - previous_total
        previous_total = total
        [date, new_cases]
      else
        previous_total = total
        nil
      end
    end.compact

    { raw: data, daily_new_cases: daily_new_cases }
  end
end
