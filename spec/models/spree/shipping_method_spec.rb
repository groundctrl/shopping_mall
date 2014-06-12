require 'spec_helper'

describe Spree::ShippingMethod do
  it { should have_many(:zones).through(:shipping_methods_zones) }
end
