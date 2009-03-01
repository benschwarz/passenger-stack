package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    post :install, 'a2enmod rewrite'
  end
  
  verify do
    has_process 'apache2'
  end
  
  requires :build_essential
end

package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end

package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  gem 'passenger' do
    post :install, 'echo -en "\n\n\n\n" | sudo passenger-install-apache2-module'
    
    # Create the passenger conf file
    post :install, 'mkdir -p /etc/apache2/extras'
    post :install, 'touch /etc/apache2/extras/passenger.conf'
    post :install, 'echo "Include /etc/apache2/extras/passenger.conf"|sudo tee -a /etc/apache2/apache2.conf'
    
    [%q(LoadModule passenger_module /usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so),
    %q(PassengerRoot /usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6),
    %q(PassengerRuby /usr/local/bin/ruby),
    %q(RailsEnv production)].each do |line|
      post :install, "echo '#{line}' |sudo tee -a /etc/apache2/extras/passenger.conf"
    end
    
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_file '/etc/apache2/extras/passenger.conf'
    has_file '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so'
    has_directory '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6'
  end
  
  requires :apache, :apache2_prefork_dev, :ruby_enterprise
end