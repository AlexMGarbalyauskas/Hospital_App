class GlobalCovidController < ApplicationController
  layout "api_three_minimal"

  def index
    service = GlobalCovidService.new
    @covid_data = service.fetch
  end
end
