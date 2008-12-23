package :ruby_enterprise do
  description 'Ruby Enterprise Edition'
  version '1.8.6-20081215'
  source "http://rubyforge.org/frs/download.php/48623/ruby-enterprise-#{version}.tar.gz" do
    custom_install 'echo -en "\n\n\n\n" | sudo ./installer'
    
    # Modify the passenger conf file to point to REE
    post :install, 'sed -i "s|^PassengerRuby [/a-zA-Z0-9.]*$|PassengerRuby /opt/ruby-enterprise-1.8.6-20081215/bin/ruby|" /etc/apache2/extras/passenger.conf'
  
    # Restart apache
    post :install, '/etc/init.d/apache2 restart'
    
    # Remove standard ruby binaries
    post :install, 'rm /usr/local/bin/ruby'
    post :install, 'rm /usr/local/bin/gem'
    post :install, 'rm /usr/local/bin/rake'
    
    # Symlink ruby enterprise binaries
    %w(ruby gem rake rails).each do |bin|
      post :install, "ln -s /opt/ruby-enterprise-#{version}/bin/#{bin} /usr/local/bin/"
    end
  end
  
  # verify do
  #   has_directory "/opt/ruby-enterprise-#{version}"
  #   has_executable "/opt/ruby-enterprise-#{version}/bin/ruby"
  # end
  
  requires :apache
  requires :passenger
  requires :zlib
  requires :openssl
end

package :zlib do
  apt "zlib1g-dev"
end

package :openssl do
  apt "libssl-dev"
end