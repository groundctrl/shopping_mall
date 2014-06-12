Spree::OptionValue.class_eval do
  has_many :option_values_variants
  has_many :variants,
           through: :option_values_variants,
           class_name: 'Spree::OptionValuesVariant'
end
