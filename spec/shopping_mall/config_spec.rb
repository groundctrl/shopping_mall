require 'spec_helper'

describe ShoppingMall do
  context '#configure' do
    it 'is a pass-through to Apartment' do
      ShoppingMall.configure do |config|
        expect(config.to_s).to eq 'Apartment'
      end
    end
  end
end
