#app/controllers/global_covid_controller.rb 



#sets up a controller to handle global COVID-19 data requests
class GlobalCovidController < ApplicationController


  #Specifies a minimal layout for API-focused views
  layout "api_three_minimal"


  #handles GET requests to the index action
  def index
    #instantiates a service object
    service = GlobalCovidService.new
    #calls the service’s method to retrieve global COVID data
    @covid_data = service.fetch
  end

end 
