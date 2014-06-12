Spree::Property.class_eval do
  has_many :properties_prototypes
  has_many :prototypes,
           through: :properties_prototypes

  def self.find_all_by_prototype(prototype)
    id = prototype
    id = prototype.id if prototype.class == Spree::Prototype
    Spree::PropertiesPrototype.where(prototype_id: id.to_i).map(&:property)
  end

  def self.outer_properties_prototypes
    arel_join = Spree::PropertiesPrototype.arel_table
    arel_table.join(arel_join, Arel::Nodes::OuterJoin)
      .on(arel_table[:id].eq(arel_join[:property_id])).join_sources
  end
end
