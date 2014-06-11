require 'spec_helper'

describe 'Dynamic model exlusions' do
  context 'configuration' do
    it 'properly excludes gem excluded models' do
      Apartment.excluded_models.each do |klass|
        base_name = klass.underscore.gsub('/', '_').pluralize
        expect(klass.constantize.table_name).to eq "public.#{base_name}"
      end
    end

    it 'appends user exclusions to gem exclusions' do
      gem_exclusions = Apartment.excluded_models
      Apartment.configure { |config| config.excluded_models += ['Foobar'] }
      expect(Apartment.excluded_models).to eq(gem_exclusions + ['Foobar'])
    end

    it 'overrides gem exclusions with user exclusions' do
      Apartment.configure { |config| config.excluded_models = [] }
      expect(Apartment.excluded_models).to_not include 'Spree::User'
    end
  end
end
