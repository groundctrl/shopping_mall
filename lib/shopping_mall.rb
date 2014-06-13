require 'spree_core'
require 'apartment'
require 'apartment/elevators/domain'
require 'apartment/elevators/first_subdomain'
require 'apartment/elevators/subdomain'
require 'shopping_mall/version'
require 'shopping_mall/engine'
require 'shopping_mall/escalator'

module ShoppingMall

  DEFAULT_SPREE_EXCLUSIONS = [
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

  ESCALATORS = %w(Domain FirstSubdomain Subdomain)

  def self.configure
    yield self if block_given?
  end

  def self.excluded_models
    Apartment.excluded_models
  end

  def self.excluded_models=(models)
    Apartment.configure { |config| config.excluded_models = models }
  end

  def self.escalator
    @escalator ||= 'Subdomain'
  end

  def self.escalator=(escalator)
    @escalator = escalator
  end

  def self.escalator_class
    "Apartment::Elevators::#{escalator}".constantize
  end
end
