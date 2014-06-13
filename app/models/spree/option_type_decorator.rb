Spree::OptionType.class_eval do
  has_many :option_types_prototypes,
           class_name: 'Spree::OptionTypesPrototype'
  has_many :prototypes,
           through: :option_types_prototypes,
           class_name: 'Spree::Prototype'
end
