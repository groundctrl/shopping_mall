require 'spree_core'
require 'apartment'
require 'apartment/elevators/generic'
require 'apartment/elevators/domain'
require 'apartment/elevators/first_subdomain'
require 'apartment/elevators/subdomain'
require 'shopping_mall/engine'

module ShoppingMall
  def self.configure
    Apartment.configure do |config|
      yield config
    end
  end
end
