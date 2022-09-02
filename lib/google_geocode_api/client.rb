# frozen_string_literal: true

module GoogleGeocodeApi
  # Client having API methods and api_key
  class Client
    # Documentation: https://developers.google.com/maps/documentation/geocoding
    BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"
    attr_reader :api_key, :adapter

    # #### Params:
    # api_key: String - Required - API key for Google Geocode API (https://developers.google.com/maps/documentation/geocoding/get-api-key#creating-api-keys)
    # adapter: Symbol - Optional - Default: :net_http - Adapter for Faraday connection
    # stubs: Faraday::Adapter::Test::Stubs - Optional - Default: nil - Stubs for Faraday connection
    # #### Example:
    # client = GoogleGeocodeApi::Client.new api_key: "test"
    # #### Description:
    # Client for Google Geocode API
    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    # #### Params:
    # place_id: String - Required - Place ID for Google Geocode API
    # #### Example:
    # GoogleGeocode::Client.new(api_key: "fake").find_place(place_id: "ChIJN1t_tDeuEmsRUsoyG83frY4")
    # #### Response:
    # #<GoogleGeocodeApi::Response:0x0000000109ec58b0
    # @results=[
    # #<GoogleGeocodeApi::Address:0x000000010a197d40
    # @formatted_address="48 Pirrama Rd, Pyrmont NSW 2009, Australia",
    # @latitude=-33.866489, @location_type="ROOFTOP", @longitude=151.1958561, @place_id="ChIJN1t_tDeuEmsRUsoyG83frY4">
    # ]>
    # #### Description:
    # Find address by place_id
    def find_place(place_id:)
      Response.new get("", { place_id: place_id })
    end

    # #### Params:
    # address: String - Required - Address String for Google Geocode API
    # #### Example:
    # GoogleGeocode::Client.new(api_key: "fake").find_address(address: "48 Pirrama Rd, Pyrmont NSW 2009, Australia")
    # #### Response:
    # #<GoogleGeocodeApi::Response:0x0000000109ec58b0
    # @results=[
    # #<GoogleGeocodeApi::Address:0x000000010a197d40
    # @formatted_address="48 Pirrama Rd, Pyrmont NSW 2009, Australia",
    # @latitude=-33.866489, @location_type="ROOFTOP", @longitude=151.1958561, @place_id="ChIJN1t_tDeuEmsRUsoyG83frY4">
    # ]>
    # #### Description:
    # Find address by providing address string
    def find_address(address:)
      Response.new get("", { address: address })
    end

    # #### Params:
    # lat: Float - Required - Latitude for Google Geocode API
    # long: Float - Required - Longitude for Google Geocode API
    # #### Example:
    # GoogleGeocode::Client.new(api_key: "fake").find_lat_long(lat: -33.866489, long: 151.1958561)
    # #### Response:
    # #<GoogleGeocodeApi::Response:0x0000000109ec58b0
    # @results=[
    # #<GoogleGeocodeApi::Address:0x000000010a197d40
    # @formatted_address="48 Pirrama Rd, Pyrmont NSW 2009, Australia",
    # @latitude=-33.866489, @location_type="ROOFTOP", @longitude=151.1958561, @place_id="ChIJN1t_tDeuEmsRUsoyG83frY4">
    # ]>
    # #### Description:
    # Find address by providing latitude and longitude values
    def find_lat_long(lat:, long:)
      Response.new get("", { latlng: "#{lat},#{long}" })
    end

    private

    # makes a get request to the given path with params
    def get(path, params = {})
      handle_response connection.get(path, params)
    end

    # handles the response from the api and raises error if any
    # returns the response if no error
    # Error codes: https://developers.google.com/maps/documentation/geocoding/requests-geocoding#StatusCodes
    # error.message: "INVALID_REQUEST: Invalid request. Invalid 'latlng' parameter"
    def handle_response(response)
      return response if %w[OK ZERO_RESULTS].include? response.body["status"]

      raise Error, "#{response.body["status"]}: #{response.body["error_message"]}"
    end

    # creates a faraday connection with base url and api_key
    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.params["key"] = api_key
        conn.request :url_encoded

        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end
  end
end
