require 'spec_helper'

describe Spree::Variant do
  it { should have_many(:option_values).through(:option_values_variants) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      option = create(:option_value)
      variant = create :variant, option_values: [option]
      expect(variant.option_values).to include option
    end
  end
end
