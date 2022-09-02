# frozen_string_literal: true

require_relative "lib/google_geocode_api/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name = "google_geocode_api"
  spec.version = GoogleGeocodeApi::VERSION
  spec.authors = ["Sulman Baig"]
  spec.email = ["sulman@hey.com"]

  spec.summary = "Google Geocode API is a light-weight Ruby wrapper for the Rubyists."
  spec.description = "Google Geocode API is a light-weight Ruby wrapper for the Rubyists. \
  It gives nice struct objects for adresses, even the raw responses are returned in nice open struct objects. \
  It uses Faraday for HTTP requests."
  spec.homepage = "https://github.com/sulmanweb/google_geocode_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sulmanweb/google_geocode_api"
  spec.metadata["changelog_uri"] = "https://github.com/sulmanweb/google_geocode_api/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[README.md]

  spec.add_dependency("faraday", "~> 2.5")
  spec.add_development_dependency("rubocop", "~> 1.35")
  spec.metadata["rubygems_mfa_required"] = "true"
end
# rubocop:enable Metrics/BlockLength
