module ShoppingMall
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'shopping_mall'

    config.autoload_paths += Dir["#{config.root}/lib"]
    config.generators { |gen| gen.test_framework :rspec }

    def self.activate
      Dir[File.join(__dir__, '../../app/**/*_decorator*.rb')].each do |klass|
        Rails.application.config.cache_classes ? require(klass) : load(klass)
      end
    end

    config.to_prepare(&method(:activate).to_proc)

    initializer "shopping_mall.user_roles" do
      Spree.user_class.class_eval do
        # Unfortunately, since `Spree.user_class#spree_roles is a HABTM
        # association, it won't work with apartment / shopping_mall
        #
        # This also won't work if it resides on app/models/user_decorator.rb
        # because it gets eval'ed (above in `.activate`) *after* Spree Core
        # adds extensions to Spree.user_class
        def spree_roles
          roles
        end
      end
    end
  end
end
