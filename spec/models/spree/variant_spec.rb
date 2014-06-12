require 'spec_helper'

describe Spree::Variant do
  it { should have_many(:option_values).through(:option_values_variants) }
end
