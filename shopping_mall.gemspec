lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shopping_mall/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = 'shopping_mall'
  spec.version       = ShoppingMall::VERSION
  spec.authors       = ['Vincent Franco', 'David Freerksen']
  spec.homepage      = 'http://github.com/groundctrl/shopping_mall'
  spec.summary       = 'Multi-tenancy for Spree >= 2.3'
  spec.description   = spec.summary
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 1.9.3'

  spec.files       = Dir['{app,config,db,lib}/**/*',
                        'MIT-LICENSE',
                        'Rakefile',
                        'README.md']
  spec.test_files   = `git ls-files -- spec/*`.split("\n")
  spec.require_path = 'lib'
  spec.has_rdoc     = false
  spec.requirements << 'none'

  spec.add_dependency 'spree_core', '~> 2.3.0'
  spec.add_dependency 'apartment', '~> 0.25'

  spec.add_development_dependency 'ffaker', '~> 1.16'
  spec.add_development_dependency 'capybara', '~> 2.2'
  spec.add_development_dependency 'database_cleaner', '1.2'
  spec.add_development_dependency 'poltergeist', '1.5'
  spec.add_development_dependency 'rspec-rails', '~> 2.14'
  spec.add_development_dependency 'factory_girl', '~> 4.4'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'simplecov', '~> 0.7'
  spec.add_development_dependency 'coffee-rails', '~> 4.0'
  spec.add_development_dependency 'sass-rails', '~> 4.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.2'
  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'pg', '~> 0.11'
  spec.add_development_dependency 'shoulda-matchers', '~> 2.5'
end
