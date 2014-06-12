module Spree
  class ProductsPromotionRule < ActiveRecord::Base
    belongs_to :product, class_name: 'Spree::Product'
    belongs_to :promotion_rule, class_name: 'Spree::PromotionRule'
  end
end
