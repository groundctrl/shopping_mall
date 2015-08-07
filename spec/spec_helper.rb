require 'simplecov'

SimpleCov.start do
  add_filter 'spec/dummy'
end

ENV['RAILS_ENV'] = 'test'

begin
  require File.expand_path('../dummy/config/environment.rb',  __FILE__)
rescue LoadError
  puts 'Could not load dummy application. Run `bundle exec rake test_app` first'
  exit
end

require 'pry-byebug'
require 'rspec/rails'
require 'capybara'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'capybara/rspec'
require 'database_cleaner'
require 'ffaker'
require 'shoulda-matchers'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f }

require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.include Spree::TestingSupport::UrlHelpers
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = false
  config.expose_current_running_example_as :example

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.strategy = strategy
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  Capybara.javascript_driver = :poltergeist
end
