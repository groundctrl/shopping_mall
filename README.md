# Shopping Mall

Multi-tenancy for Spree 2.3+ using Apartment!

## Installation

Add this line to your application's Gemfile:

    gem 'apartment_spree'

And then execute:

    $ bundle install
    
Add an initializer with:

    ShoppingMall.configure do |config|
      config.elevator = 'Subdomain'
    end

Add this to application.rb:

    config.middleware.insert_before(
      'ActiveRecord::ConnectionAdapters::ConnectionManagement',
      'ShoppingMall::Escalator'
    )

...

## Testing

Generate a dummy application

    bundle exec rake test_app

Running tests

    bundle exec rake spec

## Contributing

1. Fork it ( https://github.com/groundctrl/apartment_spree/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
