module ShoppingMall
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: true

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates initializer and inserts middleware'

      def copy_initializer
        template 'shopping_mall.rb', 'config/initializers/shopping_mall.rb'
      end

      def copy_middleware
        application do
          <<-STR

    # Inserted with shopping_mall:install
    config.middleware.insert_before(
      'ActiveRecord::ConnectionAdapters::ConnectionManagement',
      'ShoppingMall::Escalator'
    )
          STR
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=shopping_mall'
      end

      def run_migrations
        run 'bundle exec rake db:migrate'
      end
    end
  end
end
