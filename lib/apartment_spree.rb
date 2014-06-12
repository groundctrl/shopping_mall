require 'spree_core'
require 'apartment'
require 'apartment_spree/version'
require 'apartment_spree/engine'
require 'apartment_spree/elevator'

module ApartmentSpree

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

  def self.configure
    yield self if block_given?
  end

  def self.excluded_models
    Apartment.excluded_models
  end

  def self.excluded_models=(models)
    Apartment.configure { |config| config.excluded_models = models }
  end
end
