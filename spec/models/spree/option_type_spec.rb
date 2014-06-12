require 'spec_helper'

describe Spree::OptionType do
  it { should have_many(:prototypes).through(:option_types_prototypes) }
end
