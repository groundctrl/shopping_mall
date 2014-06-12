require 'spec_helper'

describe Spree::User do
  before do
    Apartment::Database.create('tenant_name') rescue "We also don't care"
    Apartment::Database.switch 'tenant_name' rescue ''
  end

  it 'is on default_schema' do
    expect(Spree::User.table_name).to eq 'public.spree_users'
  end

  it { should have_many(:roles).through(:roles_users) }
end
