ShoppingMall.configure do |config|
  # Add any models that you do not want to be multi-tenanted, but remain in the global (public) namespace.
  # A typical example would be a Customer or Tenant model that stores each Tenant's information.
  #
  # config.excluded_models = %w{ Tenant }
  #
  config.excluded_models = [
    'Spree::Tenant', # Shared to allow proper migrations and seeding to tenants
  ]

  # In order to migrate all of your Tenants you need to provide a list of Tenant names to Apartment.
  # You can make this dynamic by providing a Proc object to be called on migrations.
  # This object should yield an array of strings representing each Tenant name.
  #
  # config.tenant_names = lambda{ Customer.pluck(:tenant_name) }
  # config.tenant_names = ['tenant1', 'tenant2']
  #
  # Currently setup to allow auto-magical seeds and migrations, feel free to change.
  config.tenant_names = -> { Spree::Tenant.pluck(:name) }

  #
  # ==> PostgreSQL only options

  # Specifies whether to use PostgreSQL schemas or create a new database per Tenant.
  # The default behaviour is true.
  #
  # config.use_schemas = true

  # Apartment can be forced to use raw SQL dumps instead of schema.rb for creating new schemas.
  # Use this when you are using some extra features in PostgreSQL that can't be respresented in
  # schema.rb, like materialized views etc. (only applies with use_schemas set to true).
  # (Note: this option doesn't use db/structure.sql, it creates SQL dump by executing pg_dump)
  #
  # config.use_sql = false

  # There are cases where you might want some schemas to always be in your search_path
  # e.g when using a PostgreSQL extension like hstore.
  # Any schemas added here will be available along with your selected Tenant.
  #
  # config.persistent_schemas = %w{ hstore }

  # <== PostgreSQL only options
  #

  # By default, and only when not using PostgreSQL schemas, Apartment will prepend the environment
  # to the tenant name to ensure there is no conflict between your environments.
  # This is mainly for the benefit of your development and test environments.
  # Uncomment the line below if you want to disable this behaviour in production.
  #
  # config.prepend_environment = !Rails.env.production?
end

# Allows Paperclip to place assets within a tenants scope
Paperclip.interpolates :tenant do |attachment, _style|
  attachment.instance.tenant
end

# Namespace attachments by tenant
Spree::Image.attachment_definitions[:attachment][:url] = '/spree/products/:tenant/:id/:style/:basename.:extension'
Spree::Image.attachment_definitions[:attachment][:path] = ':rails_root/public/spree/products/:tenant/:id/:style/:basename.:extension'

# https://github.com/influitive/apartment/issues/134 for more information on this insert_before hack.
Rails.application.config.middleware.insert_before(
  'ActiveRecord::ConnectionAdapters::ConnectionManagement',
  'Apartment::Elevators::Subdomain'
)
