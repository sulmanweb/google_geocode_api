# frozen_string_literal: true

require_relative "google_geocode_api/version"
require "faraday"

module GoogleGeocodeApi
  autoload :Error, "google_geocode_api/error"
  autoload :Client, "google_geocode_api/client"
  autoload :Object, "google_geocode_api/object"
  autoload :Response, "google_geocode_api/response"
  autoload :Address, "google_geocode_api/address"
end
