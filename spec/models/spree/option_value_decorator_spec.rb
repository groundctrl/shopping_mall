require 'spec_helper'

describe Spree::OptionValue do
  it { should have_many(:variants).through(:option_values_variants) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      option_value = create :option_value, variants: [create(:variant)]
      expect(option_value.variants.size).to eq 1
    end
  end
end
