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
      prototype = FactoryGirl.create :prototype
      expect(Spree::Property.find_all_by_prototype(prototype)).to eq [prototype]
    end
  end
end
