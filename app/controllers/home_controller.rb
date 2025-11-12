#app/controllers/home_controller.rb


class HomeController < ApplicationController
  #handles GET requests to the index action
  def index
    @patients = Patient.all
  end
end
