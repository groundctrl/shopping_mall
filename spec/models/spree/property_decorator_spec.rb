require 'spec_helper'

describe Spree::Property do
  it { should have_many(:prototypes).through(:properties_prototypes) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      property = create :property, prototypes: [create(:prototype)]
      expect(property.prototypes.size).to eq 1
    end
  end
end
