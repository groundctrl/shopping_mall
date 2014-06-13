# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shopping_mall/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = 'shopping_mall'
  spec.version       = ShoppingMall::VERSION
  spec.authors       = ['Vincent Franco', 'David Freerksen']
  spec.summary       = 'Multi-tenancy for Spree >= 2.3'
  spec.description   = spec.summary
  spec.required_ruby_version = '>= 1.9.3'

  spec.homepage     = 'http://github.com/groundctrl/shopping_mall'
  spec.files        = `git ls-files`.split("\n")
  spec.test_files   = `git ls-files -- spec/*`.split("\n")
  spec.require_path = 'lib'
  spec.has_rdoc     = false
  spec.requirements  << 'none'

  spec.add_dependency 'spree_core', '~> 2.3.0.beta'
  spec.add_dependency 'apartment', '>= 0.24.0'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'capybara', '~> 2.2.1'
  spec.add_development_dependency 'database_cleaner', '1.2.0'
  spec.add_development_dependency 'poltergeist', '1.5.0'
  spec.add_development_dependency 'rspec-rails', '~> 2.14'
  spec.add_development_dependency 'factory_girl', '~> 4.4'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'coffee-rails', '~> 4.0.0'
  spec.add_development_dependency 'sass-rails', '~> 4.0.0'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pg', '>= 0.11.0'
  spec.add_development_dependency 'debugger'
  spec.add_development_dependency 'shoulda-matchers'
end
