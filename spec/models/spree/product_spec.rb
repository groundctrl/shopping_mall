require 'spec_helper'

describe Spree::Product do
  it { should have_many(:promotion_rules).through(:products_promotion_rules) }
end
