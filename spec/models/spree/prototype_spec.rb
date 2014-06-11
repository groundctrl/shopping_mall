require 'spec_helper'
require 'shoulda-matchers'

describe Spree::Prototype do
  it { should have_many(:properties).through(:properties_prototypes) }
  it { should have_many(:option_types).through(:spree_option_types_prototypes) }
end
