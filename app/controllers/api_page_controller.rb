# app/controllers/api_page_controller.rb
class ApiPageController < ApplicationController
  layout "api_two_minimal"

  def index
    service = CovidHistoricalDataService.new
    @covid_data = service.fetch_all
    @daily_new_cases = @covid_data[:daily_new_cases]
  end
end
