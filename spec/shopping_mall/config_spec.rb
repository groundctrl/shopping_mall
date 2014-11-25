require 'spec_helper'

describe ShoppingMall do
  let(:exclusions) { ['Spree::User'] }

  context '#configure' do
    it 'has default excluded_models on initialize' do
      expect(ShoppingMall.excluded_models).to eq(
        ShoppingMall::DEFAULT_SPREE_EXCLUSIONS
      )
    end

    it 'excluded_models is a pass-through to Apartment' do
      ShoppingMall.excluded_models = exclusions
      expect(Apartment.excluded_models).to eq exclusions
    end

    it 'has default escalator of `Subdomain` on initialize' do
      expect(ShoppingMall.escalator).to eq 'Subdomain'
    end

    it 'has default escalator_class of `"Apartment::Elevators::Subdomain`' do
      expect(ShoppingMall.escalator_class).to eq Apartment::Elevators::Subdomain
    end

    it 'sets values correctly' do
      ShoppingMall.configure do |config|
        config.excluded_models = exclusions
        config.escalator       = 'Domain'
      end

      expect(ShoppingMall.excluded_models).to eq exclusions
      expect(ShoppingMall.escalator).to eq 'Domain'
      expect(ShoppingMall.escalator_class).to eq Apartment::Elevators::Domain
    end
  end

  context '#excluded_models' do
    it 'sets a custom value for `excluded_models`' do
      ShoppingMall.excluded_models = exclusions
      expect(ShoppingMall.excluded_models).to eq exclusions
    end
  end

  context '#escalator' do
    ShoppingMall::ESCALATORS.each do |escalator|
      it "sets and returns `#{escalator}` as the escalator" do
        ShoppingMall.escalator = escalator
        expect(ShoppingMall.escalator).to eq escalator
      end
    end
  end

  context '#escalator_class' do
    ShoppingMall::ESCALATORS.each do |escalator|
      it "returns `#{escalator}` as the escalator_class" do
        ShoppingMall.escalator = escalator
        expect(ShoppingMall.escalator_class).to eq(
          "Apartment::Elevators::#{escalator}".constantize
        )
      end
    end
  end

  after do
    ShoppingMall.configure do |config|
      config.escalator = 'Subdomain'
      config.excluded_models = ShoppingMall::DEFAULT_SPREE_EXCLUSIONS
    end
  end
end
