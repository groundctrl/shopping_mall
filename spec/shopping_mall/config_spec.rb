require 'spec_helper'

describe ShoppingMall do
  context '#configure' do
    it 'Apartment has DEFAULT_SPREE_EXCLUSIONS on initialize' do
      expect(Apartment.excluded_models).to(
        eq(ShoppingMall::DEFAULT_SPREE_EXCLUSIONS)
      )
    end

    it 'exlcuded_models is a pass-through to Apartment' do
      exclusions = ['Spree::User']
      ShoppingMall.configure { |config| config.excluded_models = exclusions }
      expect(Apartment.excluded_models).to eq exclusions
    end

    it 'has a default escalator' do
      expect(ShoppingMall.escalator).to eq 'Subdomain'
    end

    it 'calling #escalator_class returns Subdomain escalator as default' do
      expect(ShoppingMall.escalator_class).to eq Apartment::Elevators::Subdomain
    end

    it 'accepts escalator on config' do
      ShoppingMall.configure { |config| config.escalator = 'Domain' }
      expect(ShoppingMall.escalator).to eq 'Domain'
    end
  end

  after do
    ShoppingMall.configure do |config|
      config.escalator = 'Subdomain'
      config.excluded_models = ShoppingMall::DEFAULT_SPREE_EXCLUSIONS
    end
  end
end
