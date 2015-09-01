require 'spec_helper'

describe Spree::Tenant do
  it { is_expected.to validate_uniqueness_of(:name) }
end
