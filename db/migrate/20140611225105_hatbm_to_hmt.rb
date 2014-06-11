class HatbmToHmt < ActiveRecord::Migration
  def change
    tables_to_mutate.each do |tbl|
      puts "Mutating #{tbl}"
      add_column tbl, :id, :primary_key
    end
  end

  def tables_to_mutate
    [
      :spree_option_types_prototypes,
      :spree_option_values_variants,
      :spree_orders_promotions,
      :spree_products_promotion_rules,
      :spree_products_promotion_rules_users,
      :spree_properties_prototypes,
      :spree_roles_users,
      :spree_shipping_methods_zones
    ]
  end
end
