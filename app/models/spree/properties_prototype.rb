module Spree
  class PropertiesPrototype < ActiveRecord::Base
    belongs_to :property, class_name: 'Spree::Property'
    belongs_to :prototype, class_name: 'Spree::Prototype'
  end
end
