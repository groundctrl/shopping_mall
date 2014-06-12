Spree::Prototype.class_eval do
  has_many :properties_prototypes, class_name: 'Spree::PropertiesPrototype'
  has_many :properties,
           through: :properties_prototypes,
           class_name: 'Spree::Property'
  has_many :option_types_prototypes
  has_many :option_types,
           through: :option_types_prototypes,
           class_name: 'Spree::OptionType'
end
