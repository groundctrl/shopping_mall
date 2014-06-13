require 'spec_helper'

describe ApartmentSpree do
  context '#configure' do
    it 'Apartment has DEFAULT_SPREE_EXCLUSIONS on initialize' do
      expect(Apartment.excluded_models).to(
        eq(ApartmentSpree::DEFAULT_SPREE_EXCLUSIONS)
      )
    end

    it 'exlcuded_models is a pass-through to Apartment' do
      exclusions = ['Spree::User']
      ApartmentSpree.configure { |config| config.excluded_models = exclusions }
      expect(Apartment.excluded_models).to eq exclusions
    end

    it 'has a default elevator' do
      expect(ApartmentSpree.elevator).to eq 'Subdomain'
    end

    it 'calling #elevator_class returns Subdomain elevator as default' do
      expect(ApartmentSpree.elevator_class).to eq Apartment::Elevators::Subdomain
    end

    it 'accepts elevator on config' do
      ApartmentSpree.configure { |config| config.elevator = 'Domain' }
      expect(ApartmentSpree.elevator).to eq 'Domain'
    end
  end

  after do
    ApartmentSpree.configure do |config|
      config.elevator = 'Subdomain'
      config.excluded_models = ApartmentSpree::DEFAULT_SPREE_EXCLUSIONS
    end
  end
end
