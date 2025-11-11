# app/controllers/map_controller.rb
class MapController < ApplicationController
  require 'httparty'

  def api_page
  begin
    response = HTTParty.get("https://disease.sh/v3/covid-19/vaccine/coverage/countries?lastdays=1")
    data = response.parsed_response

    @vaccine_map = {}

    if data.is_a?(Array)
      data.each do |item|
        country = item['country'] || item['name']
        timeline = item['timeline'] || {}
        value = timeline.values.last || item['coverage'] || item['vaccinated'] || 0
        @vaccine_map[country] = value.to_i if country
      end
    elsif data.is_a?(Hash)
      @vaccine_map = data
    else
      @vaccine_map = {}
    end
  rescue => e
    Rails.logger.error("Vaccine fetch failed: #{e.message}")
    flash.now[:alert] = "Failed to fetch vaccination data"
    @vaccine_map = {}
  end

  # Render WITHOUT default application layout
  render layout: "iframe"
end


  
end
