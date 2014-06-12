Spree::Property.class_eval do
  has_many :properties_prototypes
  has_many :prototypes,
           through: :properties_prototypes,
           class_name: 'Spree::PropertiesPrototype'
end
