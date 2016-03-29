# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'football_now/version'

Gem::Specification.new do |spec|
  spec.name          = "football_now"
  spec.version       = FootballNow::VERSION
  spec.authors       = ["gnfisher"]
  spec.email         = ["me@gnfisher.com"]

  spec.summary       = %q{Get standings, results and stats on the top four European leagues from your command line.}
  spec.description   = %q{Scraping a popular football site, this gem allows you to navigate the standings, results, and stats of the teams in Europe's top competitions.}
  spec.homepage      = "http://gnfisher.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "config", "data"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "require_all"
  spec.add_runtime_dependency "capybara"
  spec.add_runtime_dependency "poltergeist"
end
