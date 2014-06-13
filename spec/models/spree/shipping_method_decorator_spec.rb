require 'spec_helper'

describe Spree::ShippingMethod do
  it { should have_many(:zones).through(:shipping_methods_zones) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      shipping_method = create :shipping_method
      expect(shipping_method.zones.size).to eq 1
    end
  end
end
