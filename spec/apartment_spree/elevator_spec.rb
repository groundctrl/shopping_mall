require 'spec_helper'

describe ApartmentSpree::Elevators::Subdomain do
  before do
    Apartment::Database.drop('tenant_name') rescue "We don't care if this fails"
    Apartment::Database.create('tenant_name')
  end

  context 'schema switching' do
    let(:app) { double 'app', call: true }

    context 'with subdomain' do
      let(:subdomain) { 'this-is-a-sub' }

      it 'Apartment::Database receives the correctly parsed tenant_schema' do
        expect(Apartment::Database).to receive(:switch)
          .with(subdomain.gsub('-','_'))

        ApartmentSpree::Elevators::Subdomain.new(app).call env_domain(subdomain)
      end

      it 'Apartment::Database is set to nil after a failed schema switch' do
        expect(app).to_not receive(:call)
        ApartmentSpree::Elevators::Subdomain.new(app).call env_domain(subdomain)
      end

      it 'assigns the requests tenant' do
        expect(Apartment::Database).to receive(:switch).with('tenant_name')
        expect(app).to receive(:call)
        ApartmentSpree::Elevators::Subdomain.new(app).call(
          env_domain('tenant-name')
        )
      end
    end

    context 'without a subdomain' do
      it 'does not receive .process_request' do
        elevator = ApartmentSpree::Elevators::Subdomain.new(app)
        expect(elevator).to_not receive(:process_request)
        elevator.call Rack::MockRequest.env_for('http://example.com')
      end
    end
  end

  def env_domain(subdomain)
    Rack::MockRequest.env_for "http://#{subdomain}.example.com"
  end
end
