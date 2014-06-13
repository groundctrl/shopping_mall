require 'spec_helper'

describe Spree::Zone do
  it { should have_many(:shipping_methods).through(:shipping_methods_zones) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      zone = create(:zone, shipping_methods: [create(:shipping_method)])
      expect(zone.shipping_methods.size).to eq 1
    end
  end
end
