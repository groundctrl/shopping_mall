Spree::Zone.class_eval do
  has_many :shipping_methods_zones, class_name: 'Spree::ShippingMethodsZone'
  has_many :shipping_methods,
           through: :shipping_methods_zones,
           class_name: 'Spree::ShippingMethod'

  scope :order_by_members, -> { order(:zone_members_count, :created_at) }
  scope :where_country_or_state, ->(address) {
    where(Spree::ZoneMember.arel_where_country_or_state(address))
  }
  scope :matching_zones_for, ->(address) {
    includes(:zone_members).
      where_country_or_state(address).
        order_by_members.
          references(:zones)
  }

  class << self
    alias_method :old_match, :match
  end

  def self.match(address)
    return unless address && matches = matching_zones_for(address)

    %w(state country).each do |zone_kind|
      match = matches.detect { |zone| zone_kind == zone.kind }
      return match if match
    end

    matches.first
  end
end
