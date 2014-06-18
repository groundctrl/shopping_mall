Spree::ZoneMember.class_eval do
  %w(country state).each do |type|
    define_singleton_method "arel_and_in_#{type}_id" do |type_id|
      send(:"with_#{type}_id", type_id).where_values.reduce(:and)
    end

    scope :"with_#{type}_id", ->(type_id) {
      where(zoneable_type: "Spree::#{type.capitalize}", zoneable_id: type_id)
    }
  end

  def self.arel_where_country_or_state(address)
    countries = arel_and_in_country_id address.country_id
    countries.or(arel_and_in_state_id address.state_id)
  end
end
