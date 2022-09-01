# frozen_string_literal: true

module GoogleGeocodeApi
  # Response object formatted from Google API response
  class Response
    attr_reader :raw_response, :results

    def initialize(response)
      @raw_response = Object.new response.body
      @results = @raw_response.results.map { |result| Address.new result }
    end
  end
end
