require 'spec_helper'

describe Spree::Role do
  it { should have_many(:users).through(:roles_users) }
end
