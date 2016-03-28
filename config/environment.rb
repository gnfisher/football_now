require 'require_all'
require 'open-uri'
require 'nokogiri'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'formatador'
require 'pry'

Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.default_max_wait_time = 120
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs_options: ['--load-images=false', '--disk-cache=false'])
end

require_all 'lib'
