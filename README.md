# Shopping Mall

Multi-tenancy for Spree 2.3+ using Apartment! This is very alpha so, as always pull requests are welcome.

[![Code Climate](https://codeclimate.com/github/groundctrl/shopping_mall.png)](https://codeclimate.com/github/groundctrl/shopping_mall)

## Installation

Add this line to your Spree application's Gemfile:

    gem 'shopping_mall' # Soon.

Run the bundle command to install it

After you install ShoppingMall you'll need to run the generator:

    rails generate shopping_mall:install

Install adds a `shopping_mall.rb` initializer to your app, and adds the following to your `application.rb`:

```ruby
config.middleware.insert_before(
  'ActiveRecord::ConnectionAdapters::ConnectionManagement',
  'ShoppingMall::Escalator'
)
```
See https://github.com/influitive/apartment/issues/134 for more information on this insert_before hack.

## Config

The following config options should be set up in the `shopping_mall.rb` initializer in your apps config:

    config/initializers/shopping_mall.rb
    
#### Escalators

Escalators are thinly wrapped Apartment::Elevators, the current escalators available are: `Subdomain`, `Domain`, and `FirstSubdomain`

#### Excluding Models

If you have some models that should always access the 'public' tenant, you can specify this by configuring Apartment using `ShoppingMall.configure`.  This will yield a config object for you.  You can set excluded models like so:

```ruby
config.excluded_models = ["Spree::User", ...] # these models will not be multi-tenanted, but remain in the global (public) namespace
```

Out of the box ShoppingMall has the following Spree models excluded

```ruby
[
  'Spree::Country',
  'Spree::Property',
  'Spree::Prototype',
  'Spree::Role',
  'Spree::State',
  'Spree::TaxRate',
  'Spree::Tracker',
  'Spree::User',
  'Spree::Zone',
  'Spree::ZoneMember'
]
```

> NOTE: Rails will always access the 'public' tenant when accessing these models,  but note that tables will be created in all schemas.  This may not be ideal, but its done this way because otherwise rails wouldn't be able to properly generate the schema.rb file.


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
