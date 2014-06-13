namespace :tenant do
  desc "Bootstraps a new tenant."
  task :bootstrap, [:db_name] => [:environment] do |t, args|
    if args[:db_name].blank?
      abort %q(You must supply db_name, with "rake tenant:bootstrap['the_db_name']")
    end

    db_name = args[:db_name].gsub('-','_')

    puts "Creating database: #{db_name}"
    ActiveRecord::Base.establish_connection #make sure we're talkin' to db
    ActiveRecord::Base.connection.execute("DROP SCHEMA IF EXISTS #{db_name} CASCADE")
    Apartment::Database.create db_name

    puts "Loading seed into database: #{db_name}"
    ENV['RAILS_CACHE_ID'] = db_name
    Apartment::Database.process(db_name) do
      Spree::Image.change_paths 'sandbox'
      ENV['AUTO_ACCEPT'] = 'true'
      ENV['SKIP_NAG'] = 'yes'

      Spree::Image.change_paths db_name

      if Rails.env.production?
        admin = Spree::User.find_or_create_by(email: email).tap do |user|
          user.email = 'god@apartment.com'
          user.login = user.email
          user.password = 'elevateme'
          user.password_confirmation = 'elevateme'
        end

        admin.roles << Spree::Role.find_or_create_by_name('admin')
        admin.save
      end

      # Hack the current method so we're able to return a gateway without a RAILS_ENV
      Spree::Gateway.class_eval do
        def self.current
          Spree::Gateway::Bogus.new
        end
      end

      puts "Bootstrap completed successfully"
    end
  end
end
