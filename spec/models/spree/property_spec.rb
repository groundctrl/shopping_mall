require 'spec_helper'

describe Spree::Property do
  it { should have_many(:prototypes).through(:properties_prototypes) }
end
