module Spree
  class PropertiesPrototype < ActiveRecord::Base
    belongs_to :properties
    belongs_to :prototypes
  end
end
