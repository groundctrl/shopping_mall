require 'spec_helper'

describe Spree::Prototype do
  it { should have_many(:properties).through(:properties_prototypes) }
  it { should have_many(:option_types).through(:option_types_prototypes) }

  context 'has_many through sanity check' do
    subject { create :prototype }

    it 'associates properties correctly' do
      expect(subject.properties.size).to eq 1
    end

    it 'associates option_types correctly' do
      subject.option_types << create(:option_type)
      expect(subject.option_types.size).to eq 1
    end
  end
end
