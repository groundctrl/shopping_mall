require 'spec_helper'

describe Spree::Promotion do
  it { should have_many(:orders).through(:orders_promotions) }
end
