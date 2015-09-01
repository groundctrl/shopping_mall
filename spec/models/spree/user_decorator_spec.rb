require 'spec_helper'

describe Spree::User do
  it { should have_many(:roles).through(:roles_users) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      user = create :user, roles: [create(:role)]
      expect(user.roles.size).to eq(1)
    end
  end
end
