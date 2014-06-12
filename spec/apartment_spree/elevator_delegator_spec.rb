require 'spec_helper'

describe ApartmentSpree::ElevatorDelegator do
  context 'delegation' do
    %w[Subdomain Domain FirstSubdomain].each do |domain_type|
      context "with config as #{domain_type}" do
        it "sets delegator as Apartment::Elevators::#{domain_type}" do
          ApartmentSpree.configure { |config| config.elevator = domain_type }
          test = ApartmentSpree::ElevatorDelegator.new double(foo: 'bar')
          expect(test.elevator.class.to_s).to(
            eq "Apartment::Elevators::#{domain_type}"
          )
        end
      end
    end

    it '.call is passed to elevator' do
      test = ApartmentSpree::ElevatorDelegator.new double(foo: 'bar')
      env = Rack::MockRequest.env_for('foo')
      expect(test.elevator).to receive(:call).with(env)
      test.call env
    end
  end

  after do
    ApartmentSpree.configure do |config|
      config.elevator = 'Subdomain'
      config.excluded_models = ApartmentSpree::DEFAULT_SPREE_EXCLUSIONS
    end
  end
end
