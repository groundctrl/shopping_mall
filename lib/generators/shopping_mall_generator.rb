class InitializerGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/shopping_mall.rb", <<-STR
      ShoppingMall.configure do |config|
        # Available escalators %w[Subdomain Domain FirstSubdomain]
        config.escalator = 'Subdomain'
        # By default ShoppingMall excludes the following Spree models
        # [
        #   'Spree::Country',
        #   'Spree::Property',
        #   'Spree::Prototype',
        #   'Spree::Role',
        #   'Spree::State',
        #   'Spree::TaxRate',
        #   'Spree::Tracker',
        #   'Spree::User',
        #   'Spree::Zone',
        #   'Spree::ZoneMember'
        #  ]
        #
        #  Feel free to exclude what you want!
        #config.exluded_models = ['Some::AwesomeModel']
      end
    STR

    application do
      <<-STR
        config.middleware.insert_before(
          'ActiveRecord::ConnectionAdapters::ConnectionManagement',
          'ShoppingMall::Escalator'
        )
      STR
    end
  end
end
