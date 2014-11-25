# Shopping Mall

Multi-tenancy for Spree 2.3+ using the [Apartment](https://github.com/influitive/apartment) gem and [Postgres](http://www.postgresql.org/) as the database. This is very alpha. Pull requests are welcomed.

[![Build Status](https://travis-ci.org/groundctrl/shopping_mall.svg?branch=master)](https://travis-ci.org/groundctrl/shopping_mall)
[![Code Climate](https://codeclimate.com/github/groundctrl/shopping_mall.png)](https://codeclimate.com/github/groundctrl/shopping_mall)


## Installation

#### Gem

Add this line to your Spree application's Gemfile:

    gem 'shopping_mall'

#### Stable

Add this line to your Spree application's Gemfile:

    gem 'shopping_mall', github: 'groundctrl/shopping_mall', branch: '2-3-stable'

#### Bleeding edge
Add this line to your Spree application's Gemfile:

    gem 'shopping_mall', github: 'groundctrl/shopping_mall'

> NOTE: The master branch is not guaranteed to be in a fully functioning state. It is unwise to use this branch in a production environment.

#### Bundle

Run the bundle command to install it:

    bundle install

#### Generators

After installing ShoppingMall, run the generator:

    rails generate shopping_mall:install

This will adds a `shopping_mall.rb` initializer to your app, and adds the following to your `application.rb`:

```ruby
config.middleware.insert_before(
  'ActiveRecord::ConnectionAdapters::ConnectionManagement',
  'ShoppingMall::Escalator'
)
```

> See [https://github.com/influitive/apartment/issues/134](https://github.com/influitive/apartment/issues/134) for more information on this insert_before hack.


## Config

The following config options should be set up in the `shopping_mall.rb` initializer:

#### Escalators

Escalators are thinly wrapped Apartment::Elevators, the current escalators available are: `Subdomain`, `Domain`, and `FirstSubdomain`. The default escalator is `Subdomain`.

```ruby
config.escalator = 'Subdomain'
```

#### Excluding Models

If you have some models that should always access the `public` (global) tenant, you can specify this by configuring Apartment using `ShoppingMall.configure`. This will yield a config object for you. You can set excluded models like so:

```ruby
config.excluded_models = ["Spree::User", ...] # these models will not be multi-tenanted, but remain in the global (public) namespace
```

Out of the box ShoppingMall has the following Spree models excluded:

```ruby
[
  'Spree::Country',
  'Spree::Property',
  'Spree::Prototype',
  'Spree::Role',
  'Spree::RolesUser',
  'Spree::State',
  'Spree::TaxRate',
  'Spree::Tracker',
  'Spree::User',
  'Spree::Zone',
  'Spree::ZoneMember'
]
```

> NOTE: Rails will always access the `public` tenant when accessing these models, but note that tables will be created in all schemas. This may not be ideal, but its done this way because otherwise rails wouldn't be able to properly generate the `schema.rb` file.


## Create Tenant (Rake Task)

The tenant name will change depending on the escalator you are using. See the [Escalators](#escalators) section for more information.

    rake tenant:create['tenant_name_here']

If the tenant already exists, it will *not* be overwritten. It will need to be *dropped* before it can be recreated.

#### Subdomain

This escalator will use the entire subdomain, including nested subdomains. If your domain is `foo.example.com`, the rake task you would need to run is:

    rake tenant:create['foo']

If your domain is `foo.bar.example.com`, the rake task you would need to run is:

    rake tenant:create['foo.bar']

You can also exclude certain subdomains. Create a file named `subdomain_exclusions.rb` in `config/initializers/apartment`. Inside it add:

```ruby
Apartment::Elevators::Subdomain.excluded_subdomains = ['www']
```

Typical subdomains may include: `public`, `www` and `admin`

#### Domain

Domains elevators exclude subdomains and TLD such as `.com` or `.co.uk`. If your domain is `www.example.com`, `example.com` or `www.example.co.uk`, the rake task you would need to run is:

    rake tenant:create['example']

Note that if the URL is anything other than `www`, it will be used as part of the tenant. This means `foo.example.com` would need to be:

    rake tenant:create['foo.example']

#### FirstSubdomain

This is similar to the Subdomain elevator. This will use the first available subdomain. If your domain is `foo.example.com` or `foo.bar.example.com`, the rake task you would need to run is:

    rake tenant:create['foo']

#### Admin User

While creating a tenant, you will be asked to create an admin at the same time. If you accept, you will be prompted to supply an email address and a password for the new admin user. If the user already exists, whether the user is an admin or not, the user will neither be created nor assigned to the admin role.

> NOTE: This admin user will be created on the tenant provided in the `tenant:create` Rake task. If `users` is a shared table and the admin needs to be a global admin, this should be applied to the user in the Spree admin rather than in the Rake task.


## Drop Tenant (Rake Task)

You must confirm dropping the tenant before the action runs. To drop a tenant, run the following Rake task:

    rake tenant:drop['tenant_name_here']

> NOTE: Dropping a tenant is a destructive action. Dropping a tenant will remove all data for this tenant. There is no way to retrieve the data in the future unless backups are available.

> NOTE: The `public` tenant cannot be dropped from here.


## Testing

Generate a dummy application

    bundle exec rake test_app

Running tests

    bundle exec rake spec


## Contributing

1. Fork it ( https://github.com/groundctrl/shopping_mall/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
