#app/controllers/api_page_controller.rb

class ApiPageController < ApplicationController
  layout "api_two_minimal"

  def index

    #instantiates a service object 
    #responsible for fetching COVID-19 historical data.
    service = CovidHistoricalDataService.new


    #Calls the service’s 
    #method to retrieve all relevant COVID data.
    @covid_data = service.fetch_all


    #Extracts a specific subset of the data 
    #(daily new cases) for direct use in the view
    @daily_new_cases = @covid_data[:daily_new_cases]
  end
end
