class Spree::PropertiesPrototype < ActiveRecord::Base
  belongs_to :properties
  belongs_to :prototypes
end
