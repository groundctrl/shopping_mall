require 'spec_helper'

describe Spree::Product do
  it { should have_many(:promotion_rules).through(:products_promotion_rules) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      product = create :product, promotion_rules: [Spree::PromotionRule.new]
      expect(product.promotion_rules.size).to eq 1
    end
  end
end
