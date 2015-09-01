require 'spec_helper'

describe Spree::Image do
  describe '.tenant_proc' do
    it 'returns ShoppingMall::Store#current' do
      expect(described_class.tenant_proc.call).to eq Apartment::Tenant.current
    end
  end

  describe '#tenant' do
    before do
      %w(tenant1 tenant2).each do |name|
        Apartment::Tenant.create name
      end
    end

    context 'with different tenants' do
      it 'returns ShoppingMall::Store#current' do
        Apartment::Tenant.switch! 'tenant1'
        expect(subject.tenant).to eq 'tenant1'

        Apartment::Tenant.switch! 'tenant2'
        expect(subject.tenant).to eq 'tenant2'
      end
    end
  end

  describe 'tenant directory within image path' do
    before do
      Apartment::Tenant.create 'tenant1'

      Paperclip.interpolates :tenant do |attachment, _style|
        attachment.instance.tenant
      end
      Spree::Image.attachment_definitions[:attachment][:url] =
        '/spree/products/:tenant/:id/:style/:basename.:extension'
      Spree::Image.attachment_definitions[:attachment][:path] =
        ':rails_root/public/spree/products/:tenant/:id/:style/:basename.:extension'

      Apartment::Tenant.switch! 'tenant1'
    end

    it 'uses current tenant' do
      subject.attachment = Rack::Test::UploadedFile.new(
        'spec/fixtures/test_cat.jpg'
      )

      expect(subject.attachment.url(:original)).
        to start_with "/spree/products/tenant1//original/test_cat.jpg"
    end
  end
end
