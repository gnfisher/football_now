# require 'require_all'
require 'open-uri'
require 'nokogiri'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'


Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.default_max_wait_time = 120
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs_options: ['--load-images=false', '--disk-cache=false'])
end

require 'football_now/version'
require 'cli'
require 'db'
require 'importer'
require 'league'
require 'match'
require 'scraper'
require 'team'
