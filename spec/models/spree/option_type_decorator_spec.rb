require 'spec_helper'

describe Spree::OptionType do
  it { should have_many(:prototypes).through(:option_types_prototypes) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      option_type = create :option_type, prototypes: [create(:prototype)]
      expect(option_type.prototypes.size).to eq 1
    end
  end
end
