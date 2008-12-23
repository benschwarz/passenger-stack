# Contains software created by Phusion.nl which is Ruby Enterprise Edition
# and mod_rails
package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  gem 'passenger' do
    post :install, 'echo -en "\n\n\n\n" | passenger-install-apache2-module'
    
    # Create the passenger conf file
    post :install, 'mkdir /etc/apache2/extras'
    post :install, 'touch /etc/apache2/extras/passenger.conf'
    post :install, "echo 'Include /etc/apache2/extras/passenger.conf' >> /etc/apache2/apache2.conf"
    
    [%q(LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so),
    %q(PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-2.0.6),
    %q(PassengerRuby /usr/bin/ruby1.8),
    %q(RailsEnv development)].each do |line|
      post :install, "echo '#{line}' >> /etc/apache2/extras/passenger.conf"
    end
    
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_file '/etc/apache2/extras/passenger.conf'
    has_file '/usr/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so'
    has_directory '/usr/lib/ruby/gems/1.8/gems/passenger-2.0.6'
  end
  
  requires :apache
  requires :apache2_prefork_dev
end

package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    post :install, 'a2enmod rewrite'
  end
  
  verify do
    has_process 'apache2'
  end
end

package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end