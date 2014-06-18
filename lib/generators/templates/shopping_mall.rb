ShoppingMall.configure do |config|
  # Available escalators %w[Subdomain Domain FirstSubdomain]
  config.escalator = 'Subdomain'
  # By default ShoppingMall excludes the following Spree models
  # [
  #   'Spree::Country',
  #   'Spree::Property',
  #   'Spree::Prototype',
  #   'Spree::Role',
  #   'Spree::State',
  #   'Spree::TaxRate',
  #   'Spree::Tracker',
  #   'Spree::User',
  #   'Spree::Zone',
  #   'Spree::ZoneMember'
  #  ]
  #
  #  Feel free to exclude what you want!
  #config.excluded_models = ['Some::AwesomeModel']
end
