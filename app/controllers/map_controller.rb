# app/controllers/map_controller.rb
class MapController < ApplicationController
  def api_page
    begin
      response = CovidVaccineDataService.new.fetch_vaccine_data
      data = response.parsed_response  # disease.sh returns an Array of country entries

      @vaccine_map = {}

      if data.is_a?(Array)
        data.each do |item|
          country = item['country'] || item['name']
          timeline = item['timeline'] || {}
          # take the last value from timeline (the endpoint returns { date => value })
          value = timeline.values.last || item['coverage'] || item['vaccinated'] || 0
          @vaccine_map[country] = value.to_i if country
        end
      elsif data.is_a?(Hash)
        # already a mapping
        @vaccine_map = data
      else
        @vaccine_map = {}
      end
    rescue => e
      Rails.logger.error("Vaccine fetch failed: #{e.message}")
      flash.now[:alert] = "Failed to fetch vaccination data"
      @vaccine_map = {}
    end
    # view will use @vaccine_map and @vaccine_map.to_json
  end
end
