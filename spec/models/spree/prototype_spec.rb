require 'spec_helper'

describe Spree::Prototype do
  it { should have_many(:properties).through(:properties_prototypes) }
  it { should have_many(:option_types).through(:option_types_prototypes) }
end
