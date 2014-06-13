require 'spec_helper'

describe ShoppingMall::Escalator do
  context 'delegation' do
    %w[Subdomain Domain FirstSubdomain].each do |domain_type|
      context "with config as #{domain_type}" do
        it "sets delegator as Apartment::Elevator::#{domain_type}" do
          ShoppingMall.configure { |config| config.escalator = domain_type }
          test = ShoppingMall::Escalator.new double(foo: 'bar')
          expect(test.escalator.class.to_s).to(
            eq "Apartment::Elevators::#{domain_type}"
          )
        end
      end
    end

    it '.call is passed to escalator' do
      test = ShoppingMall::Escalator.new double(foo: 'bar')
      env = Rack::MockRequest.env_for('foo')
      expect(test.escalator).to receive(:call).with(env)
      test.call env
    end
  end

  after do
    ShoppingMall.configure do |config|
      config.escalator = 'Subdomain'
      config.excluded_models = ShoppingMall::DEFAULT_SPREE_EXCLUSIONS
    end
  end
end
