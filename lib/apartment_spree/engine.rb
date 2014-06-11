module ApartmentSpree
  class Engine < Rails::Engine
    engine_name 'apartment_spree'

    config.autoload_paths += %W[#{config.root}/lib]
    config.generators { |gen| gen.test_framework :rspec }

    def self.activate
      Dir[File.join(__dir__, '../../app/**/*_decorator*.rb')].each do |klass|
        Rails.application.config.cache_classes ? require(klass) : load(klass)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
