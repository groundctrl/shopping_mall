require 'spec_helper'

describe ApartmentSpree do
  context '#configure' do
    it 'Apartment has DEFAULT_SPREE_EXCLUSIONS' do
      expect(Apartment.excluded_models).to(
        eq(ApartmentSpree::DEFAULT_SPREE_EXCLUSIONS)
      )
    end

    it 'exlcuded_models is a pass-through to Apartment' do
      exclusions = ['Spree::User']
      ApartmentSpree.configure { |config| config.excluded_models = exclusions }
      expect(Apartment.excluded_models).to eq exclusions
    end

    it 'overrides gem exclusions with user exclusions' do
      ApartmentSpree.configure { |config| config.excluded_models = [] }
      expect(Apartment.excluded_models).to_not include 'Spree::User'
    end
  end
end
