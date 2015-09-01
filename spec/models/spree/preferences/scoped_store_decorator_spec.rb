require 'spec_helper'

describe Spree::Preferences::ScopedStore do
  before do
    Apartment::Tenant.create('tenant_name1')
  end

  describe '#fetch' do
    it 'appends current tenant to RAILS_CACHE_ID' do
      ENV['RAILS_CACHE_ID'] = 'cache_id'
      fake_instance = double('FakeStoreInstance', fetch: true)
      allow(Spree::Preferences::Store).to receive(:instance) { fake_instance }

      Apartment::Tenant.switch!('tenant_name1')

      scoped_store = described_class.new('prefix')

      scoped_store.fetch('neat')

      expect(fake_instance).to have_received(:fetch).
        with 'cache_idtenant_name1/prefix/neat'
    end
  end
end
