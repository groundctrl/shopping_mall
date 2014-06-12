Spree::Product.class_eval do
  has_many :products_promotion_rules
  has_many :promotion_rules,
           through: :products_promotion_rules,
           class_name: 'Spree::ProductsPromotionRule'
end
