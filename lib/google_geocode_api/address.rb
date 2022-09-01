# frozen_string_literal: true

module GoogleGeocodeApi
  # Address object
  class Address
    attr_reader :formatted_address, :place_id, :longitude, :latitude, :location_type

    def initialize(obj)
      @formatted_address = obj.formatted_address
      @place_id = obj.place_id
      @latitude = obj.geometry.location.lat
      @longitude = obj.geometry.location.lng
      @location_type = obj.geometry.location_type
    end
  end
end
