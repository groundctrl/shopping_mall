Spree::Prototype.class_eval do
  has_many :properties, through: :properties_prototypes, class_name: 'Spree::PropertiesPrototype'
end
