require 'spec_helper'

describe Spree::Order do
  it { should have_many(:promotions).through(:orders_promotions) }
end
