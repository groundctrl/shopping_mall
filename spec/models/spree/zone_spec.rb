require 'spec_helper'

describe Spree::Zone do
  it { should have_many(:shipping_methods).through(:shipping_methods_zones) }
end
