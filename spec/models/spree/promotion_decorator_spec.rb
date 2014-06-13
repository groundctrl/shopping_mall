require 'spec_helper'

describe Spree::Promotion do
  it { should have_many(:orders).through(:orders_promotions) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      promotion = create :promotion, orders: [create(:order)]
      expect(promotion.orders.size).to eq 1
    end
  end
end
