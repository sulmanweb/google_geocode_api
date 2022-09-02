# GoogleGeocodeApi

Google Geocode API is a light-weight Ruby wrapper for the Rubyists. It gives nice struct objects for adresses, even the raw responses are returned in nice open struct objects. It uses Faraday for HTTP requests.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add google_geocode_api

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install google_geocode_api

---

## Usage

### API Documentation

The API documentation can be found at [https://developers.google.com/maps/documentation/geocoding/start](https://developers.google.com/maps/documentation/geocoding/start).

### Get an API key
You can get API for the google by doing the following [here](https://developers.google.com/maps/documentation/geocoding/get-api-key#creating-api-keys).

### Configuration

```ruby
require 'google_geocode_api'
client = GoogleGeocodeApi::Client.new(api_key: ENV['GOOGLE_API_KEY'])
```
Params:
- `api_key`: String - Required - The API key for the google geocode api.

Response:
```ruby
#<GoogleGeocodeApi::Client:0x00000001055fc318 @adapter=:net_http, @api_key="YOUR_API_KEY", @stubs=nil>
```

### Get place information provided place id

```ruby
resp = GoogleGeocode::Client.new(api_key: "fake").find_place(place_id: "ChIJN1t_tDeuEmsRUsoyG83frY4")
```
Params:
- `place_id`: String - Required - The place id for the place you want to get information for.

Response:
```ruby
resp.results
=> #<GoogleGeocodeApi::Response:0x0000000109ec58b0 @results=[#<GoogleGeocodeApi::Address:0x000000010a197d40 @formatted_address="48 Pirrama Rd, Pyrmont NSW 2009, Australia", @latitude=-33.866489, @location_type="ROOFTOP", @longitude=151.1958561, @place_id="ChIJN1t_tDeuEmsRUsoyG83frY4">]>
```

> Also `raw_response` is available if you want the raw response from the API. This is useful if you want to do something with the raw response. Also that response is in OpenStruct Object which is a nice wrapper for the raw response and you can use 'dot' notation.

### Get address information provided address string

```ruby
resp = GoogleGeocode::Client.new(api_key: "fake").find_address(address: "48 Pirrama Rd, Pyrmont NSW 2009, Australia")
```
Params:
- `address`: String - Required - The address you want to get information for.

Response:
```ruby
resp.results
=> #<GoogleGeocodeApi::Response:0x0000000109ec58b0 @results=[#<GoogleGeocodeApi::Address:0x000000010a197d40 @formatted_address="48 Pirrama Rd, Pyrmont NSW 2009, Australia", @latitude=-33.866489, @location_type="ROOFTOP", @longitude=151.1958561, @place_id="ChIJN1t_tDeuEmsRUsoyG83frY4">]>
```
> Also `raw_response` is available if you want the raw response from the API. This is useful if you want to do something with the raw response. Also that response is in OpenStruct Object which is a nice wrapper for the raw response and you can use 'dot' notation.

### Get address information provided latitute and longitude

```ruby
resp = GoogleGeocode::Client.new(api_key: "fake").find_lat_long(latitude: -33.866489, longitude: 151.1958561)
```
Params:
- `lat`: Float - Required - The latitude you want to get information for.
- `long`: Float - Required - The longitude you want to get information for.

Response:
```ruby
resp.results
=> #<GoogleGeocodeApi::Response:0x0000000109ec58b0 @results=[#<GoogleGeocodeApi::Address:0x000000010a197d40 @formatted_address="48 Pirrama Rd, Pyrmont NSW 2009, Australia", @latitude=-33.866489, @location_type="ROOFTOP", @longitude=151.1958561, @place_id="ChIJN1t_tDeuEmsRUsoyG83frY4">]>
```

> Also `raw_response` is available if you want the raw response from the API. This is useful if you want to do something with the raw response. Also that response is in OpenStruct Object which is a nice wrapper for the raw response and you can use 'dot' notation.

### Error Handling

```ruby
begin
  client.find_lat_long(latitude: -33.866489, longitude: 151.1958561)
rescue GoogleGeocode::Error => e
  puts e.message
end
```

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/google_geocode_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/google_geocode_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GoogleGeocodeApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/google_geocode_api/blob/main/CODE_OF_CONDUCT.md).
