namespace :tenant do
  desc 'Create a new tenant.'
  task :create, [:tenant] => [:environment] do |t, args|
    if args.tenant.blank?
      raise "You must supply a tenant with `rake tenant:create['tenant']`"
    end

    tenant = args.tenant.gsub('-', '_')

    ActiveRecord::Base.establish_connection

    if schema_in_use?(tenant)
      raise "Tenant `#{tenant}` already exists. Will not overwrite."
    end

    Apartment::Tenant.create(tenant)

    puts 'Tenant created successfully'
    ENV['RAILS_CACHE_ID'] = tenant

    Apartment::Tenant.process(tenant) do
      if agree('Does a new admin user need to be created? [Y/n]')
        Rake::Task['user:admin'].invoke(tenant)
      end

      # Hack the current method so we're able to return a gateway
      # without a RAILS_ENV
      Spree::Gateway.class_eval do
        def self.current
          Spree::Gateway::Bogus.new
        end
      end
    end
  end

  desc 'Drop an existing tenant.'
  task :drop, [:tenant] => [:environment] do |t, args|
    if args.tenant.blank? or args.tenant.downcase == 'public'
      raise "You must supply a tenant name, with `rake tenant:drop['tenant']`"
    end

    tenant = args.tenant.gsub('-', '_')

    if agree('WARNING: This is a destructive action. Dropping a tenant will
         remove all data for this tenant. There is no way to retrieve the
         data in the future unless backups are available. Are you sure you
         wish to continue? [Y/n]')
      begin
        Apartment::Tenant.drop(args.tenant)
        puts "Tenant `#{tenant}` has been dropped. It is no longer available."
      rescue => err
        raise err
      end
    else
      puts 'No tenants have been dropped.'
    end
  end

  # Check is schema is currently in use
  def schema_in_use?(tenant)
    schema = ActiveRecord::Base.connection
                               .execute("SELECT schema_name
                                         FROM information_schema.schemata
                                         WHERE schema_name = '#{tenant}'")
    schema.ntuples > 0
  end
end
