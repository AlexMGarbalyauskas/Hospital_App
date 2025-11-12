# app/controllers/map_controller.rb


#1 
class MapController < ApplicationController




  # action to fetch vaccination data and render map view
  # gem used 
  require 'httparty'





  # GET /map/api_page file
  def api_page


    # Fetch vaccination data from external API
    begin 

      #example API endpoint for vaccination data
      response = HTTParty.get("https://disease.sh/v3/covid-19/vaccine/coverage/countries?lastdays=1")
      data = response.parsed_response

      #process data into a hash mapping country 
      #names to vaccination counts
      @vaccine_map = {}

      #handle different possible data structures
      if data.is_a?(Array)

        #each item represents a country's data
        data.each do |item|
          country  = item['country'] || item['name']
          timeline = item['timeline'] || {}
          value    = timeline.values.last || item['coverage'] || item['vaccinated'] || 0
          @vaccine_map[country] = value.to_i if country
        end

      #handle single country data case
      elsif data.is_a?(Hash)
        @vaccine_map = data

      #handle unexpected data format
      else
        @vaccine_map = {}
      end

    #error handling for API request failures
    rescue => e
      Rails.logger.error("Vaccine fetch failed: #{e.message}")
      flash.now[:alert] = "Failed to fetch vaccination data"
      @vaccine_map = {}
    end #end of rescue

    # Render WITHOUT default application layout
    render layout: "iframe"

  end #end of api_page action 

end #1# end of MapController
