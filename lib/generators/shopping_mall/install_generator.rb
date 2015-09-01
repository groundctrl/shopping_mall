module ShoppingMall
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: true

      source_root File.expand_path('../../templates', __FILE__)

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=shopping_mall'
      end

      def run_migrations
        run 'bundle exec rake db:migrate'
      end

      desc 'Creates initializer and inserts middleware'
      def copy_initializer
        template 'shopping_mall.rb', 'config/initializers/shopping_mall.rb'
      end

      def add_namespacing_to_cache
        %w{development production}.each do |env|
          application(nil, env: env) do
            'config.cache_store = :memory_store, { namespace: -> { Apartment::Tenant.current } }'
          end
        end
      end
    end
  end
end
