Apartment.configure do |config|
  config.excluded_models = [
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
end
