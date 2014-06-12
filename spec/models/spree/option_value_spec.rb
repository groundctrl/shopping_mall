require 'spec_helper'

describe Spree::OptionValue do
  it { should have_many(:variants).through(:option_values_variants) }
end
