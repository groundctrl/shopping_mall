module Spree
  class ShippingMethodsZone < ActiveRecord::Base
    belongs_to :shipping_method, class_name: 'Spree::ShippingMethod'
    belongs_to :zone, class_name: 'Spree::Zone'
  end
end
