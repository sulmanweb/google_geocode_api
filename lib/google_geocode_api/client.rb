# frozen_string_literal: true

module GoogleGeocodeApi
  # Client having API methods and api_key
  class Client
    BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"
    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def find_place_by(place_id:)
      Response.new handle_response(get("", { place_id: place_id }))
    end

    def find_address(address:)
      Response.new handle_response(get("", { address: address }))
    end

    def find_lat_long(lat:, long:)
      Response.new handle_response(get("", { latlng: "#{lat},#{long}" }))
    end

    private

    def get(path, params = {})
      connection.get(path, params)
    end

    def handle_response(response)
      return response if %w[OK ZERO_RESULTS].include? response.body["status"]

      raise Error, "#{response.body["status"]}: #{response.body["error_message"]}"
    end

    def connection
      @connection ||= Faraday.new(url: BASE_URL) do |conn|
        conn.params["key"] = api_key
        conn.request :url_encoded

        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end
  end
end
