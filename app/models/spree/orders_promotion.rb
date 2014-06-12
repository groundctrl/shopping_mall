module Spree
  class OrdersPromotion < ActiveRecord::Base
    belongs_to :order, class_name: 'Spree::Order'
    belongs_to :promotion, class_name: 'Spree::Promotion'
  end
end
