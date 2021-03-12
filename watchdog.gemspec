# coding: utf-8
$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "watchdog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "watchdog"
  spec.version     = Watchdog::VERSION
  spec.authors     = ["Stéphane Maniaci"]
  spec.email       = ["stephane.maniaci@digital.cabinet-office.gov.uk"]
  spec.homepage    = "https://github.com/alphagov/govwifi"
  spec.summary     = "Watchdog is a Rails engine to map widgets onto a dashboard."
  spec.description = "Watchdog lets you declare your widgets in YAML format then will take care of the rendering. Declare you widgets, implement your data sources and go."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "haml-rails"
  spec.add_dependency "chartkick"

  spec.add_development_dependency "sassc-rails"
end
