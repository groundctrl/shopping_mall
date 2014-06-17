require 'spec_helper'

describe Spree::Zone do
  it { should have_many(:shipping_methods).through(:shipping_methods_zones) }

  context 'has_many through sanity check' do
    it 'associates correctly' do
      zone = create(:zone, shipping_methods: [create(:shipping_method)])
      expect(zone.shipping_methods.size).to eq 1
    end
  end

  context "#match" do
    let(:country_zone) { create(:zone, name: 'CountryZone') }
    let(:country) do
      country = create(:country)
      # Create at least one state for this country
      state = create(:state, country: country)
      country
    end

    before { country_zone.members.create(zoneable: country) }

    context "when there is only one qualifying zone" do
      let(:address) { create(:address, country: country, state: country.states.first) }

      it "should return the qualifying zone" do
        Spree::Zone.match(address).should == country_zone
      end
    end

    context "when there are two qualified zones with same member type" do
      let(:address) { create(:address, country: country, state: country.states.first) }
      let(:second_zone) { create(:zone, name: 'SecondZone') }

      before { second_zone.members.create(zoneable: country) }

      context "when both zones have the same number of members" do
        it "should return the zone that was created first" do
          Spree::Zone.match(address).should == country_zone
        end
      end

      context "when one of the zones has fewer members" do
        let(:country2) { create(:country) }

        before { country_zone.members.create(zoneable: country2) }

        it "should return the zone with fewer members" do
          Spree::Zone.match(address).should == second_zone
        end
      end
    end

    context "when there are two qualified zones with different member types" do
      let(:state_zone) { create(:zone, name: 'StateZone') }
      let(:address) { create(:address, country: country, state: country.states.first) }

      before { state_zone.members.create(zoneable: country.states.first) }

      it "should return the zone with the more specific member type" do
        Spree::Zone.match(address).should == state_zone
      end
    end

    context "when there are no qualifying zones" do
      it "should return nil" do
        Spree::Zone.match(Spree::Address.new).should be_nil
      end
    end
  end
end
