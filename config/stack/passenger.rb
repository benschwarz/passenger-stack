package :passenger do
  description 'Phusion Passenger (mod_rails)'
  version '2.1.3'
  gem 'passenger' do
    post :install, 'echo -en "\n\n\n\n" | sudo passenger-install-apache2-module'

    # Create the passenger conf file
    post :install, 'mkdir -p /etc/apache2/extras'
    post :install, 'touch /etc/apache2/extras/passenger.conf'
    post :install, 'echo "Include /etc/apache2/extras/passenger.conf"|sudo tee -a /etc/apache2/apache2.conf'

    [%Q(LoadModule passenger_module /usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so),
    %Q(PassengerRoot /usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-#{version}),
    %q(PassengerRuby /usr/local/bin/ruby),
    %q(RailsEnv production)].each do |line|
      post :install, "echo '#{line}' |sudo tee -a /etc/apache2/extras/passenger.conf"
    end

    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end

  verify do
    has_file "/etc/apache2/extras/passenger.conf"
    has_file "/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so"
    has_directory "/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-#{version}"
  end

  requires :apache, :apache2_prefork_dev, :ruby_enterprise
end