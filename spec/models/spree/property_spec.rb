require 'spec_helper'

describe Spree::Property do
  it { should have_many(:prototypes).through(:properties_prototypes) }

  context 'has_many through' do
    it 'assigns correctly' do
      property = FactoryGirl.create :property
      property.prototypes << FactoryGirl.create(:prototype)

      expect(property.prototypes.size).to eq 1
    end
  end

  context '#find_all_by_prototype' do
    it 'returns all found properties' do
      properties ||= (1..5).map { FactoryGirl.create(:property) }
      prototype = FactoryGirl.create :prototype, properties: properties

      expect(Spree::Property.find_all_by_prototype(prototype)).to eq properties
    end
  end
end
