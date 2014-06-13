require 'spree_core'
require 'apartment'
require 'apartment/elevators/domain'
require 'apartment/elevators/first_subdomain'
require 'apartment/elevators/subdomain'
require 'apartment_spree/version'
require 'apartment_spree/engine'
require 'apartment_spree/elevator_delegator'

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

  ELEVATORS = %w(Domain FirstSubdomain Subdomain)

  def self.configure
    yield self if block_given?
  end

  def self.excluded_models
    Apartment.excluded_models
  end

  def self.excluded_models=(models)
    Apartment.configure { |config| config.excluded_models = models }
  end

  def self.elevator
    @elevator ||= 'Subdomain'
  end

  def self.elevator=(elevator)
    @elevator = elevator
  end

  def self.elevator_class
    "Apartment::Elevators::#{elevator}".constantize
  end
end
