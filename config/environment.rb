require 'require_all'
require 'open-uri'
require 'nokogiri'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
Dir["lib/*.rb"].each {|file| require_relative "../#{file}" }
# require_all "../lib"


Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.default_max_wait_time = 120
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs_options: ['--load-images=false', '--disk-cache=false'])
end
