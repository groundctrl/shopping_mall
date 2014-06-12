Spree::Property.class_eval do
  has_many :properties_prototypes, class_name: 'Spree::PropertiesPrototype'
  has_many :prototypes,
           through: :properties_prototypes,
           class_name: 'Spree::Prototype'

  def self.find_all_by_prototype(prototype)
    id = prototype
    id = prototype.id if prototype.class == Spree::Prototype
    Spree::PropertiesPrototype.where(prototype_id: id).map(&:property)
  end
end
