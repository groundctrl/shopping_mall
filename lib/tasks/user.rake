namespace :user do
  # NOTE: Task descriptions are commented out because we'd rather have people
  # create their own accounts rather than have then created for them. These
  # will still be available by running `rake -vT`

  # desc 'Create a basic user'
  task :basic, [:tenant] => :environment do |t, args|
    create_user(args.tenant, false)
  end

  # desc 'Create an admin user'
  task :admin, [:tenant] => :environment do |t, args|
    create_user(args.tenant, true)
  end

  def create_user(tenant, is_admin)
    tenant = tenant_name(tenant)

    ActiveRecord::Base.establish_connection

    ENV['RAILS_CACHE_ID'] = tenant

    Apartment::Tenant.process(tenant) do
      ENV['AUTO_ACCEPT'] = 'true'
      ENV['SKIP_NAG']    = 'yes'

      email = input_prompt('Email',
                          true,
                          /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i,
                          'Invalid email.')

      password = input_prompt('Password',
                              '*',
                              /^(|.{5,40})$/,
                              'Password must be 5-40 characters long.')

      attributes = {
        password:              password,
        password_confirmation: password,
        email:                 email,
        login:                 email
      }

      if Spree::User.find_by_email(email)
        raise "Email address #{email} is already in use. User not created."
      end

      user = Spree::User.new(attributes)
      user.save

      if is_admin
        role = Spree::Role.find_or_create_by(name: 'admin')
        user.spree_roles << role
        user.save
        puts 'Admin user created successfully.'
      else
        puts 'User created successfully.'
      end
    end
  end

  def tenant_name(tenant)
    return nil  if tenant.empty?
    tenant.gsub('-', '_')
  end

  def input_prompt(prompt_for, echo, valid_regex, invalid_msg)
    ask("#{prompt_for}: ") do |q|
      q.echo                  = echo
      q.validate              = valid_regex
      q.responses[:not_valid] = invalid_msg
      q.whitespace            = :strip
    end
  end
end
