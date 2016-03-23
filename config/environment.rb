require 'require_all'
require 'open-uri'
require 'nokogiri'
require 'net/http'

require 'pry'

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.default_max_wait_time = 120
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs_options: ['--load-images=false', '--disk-cache=false'])
end

require_all 'lib'
