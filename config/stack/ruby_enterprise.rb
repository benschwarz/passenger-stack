package :ruby_enterprise, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  version '1.8.6-20081215'
  source 'http://rubyforge.org/frs/download.php/48623/ruby-enterprise-1.8.6-20081215.tar.gz' do
    custom_install 'echo -en "\n\n\n\n" | ./installer'
    
    # Modify the passenger conf file to point to REE
    post :install, 'sed -i "s|^PassengerRuby [/a-zA-Z0-9.]*$|PassengerRuby /opt/ruby-enterprise-1.8.6-20081215/bin/ruby|" /etc/apache2/extras/passenger.conf'
  
    # Restart apache
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_directory '/opt/ruby-enterprise-1.8.6-20081215'
    has_executable '/opt/ruby-enterprise-1.8.6-20081215/bin/ruby'
  end
  
  requires :apache
end