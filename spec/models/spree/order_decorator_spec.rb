require 'spec_helper'

describe Spree::Order do
  it { should have_many(:promotions).through(:orders_promotions) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      order = create :order, promotions: [create(:promotion)]
      expect(order.promotions.size).to eq 1
    end
  end

end
