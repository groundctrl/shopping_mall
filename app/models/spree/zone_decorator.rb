Spree::Zone.class_eval do
  has_many :shipping_methods_zones, class_name: 'Spree::ShippingMethodsZone'
  has_many :shipping_methods,
           through: :shipping_methods_zones,
           class_name: 'Spree::ShippingMethod'
end
