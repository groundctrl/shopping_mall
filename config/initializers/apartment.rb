Apartment.configure do |config|
  config.excluded_models = ['Spree::Tenant']
  config.tenant_names = -> { Spree::Tenant.pluck(:name) }
end
