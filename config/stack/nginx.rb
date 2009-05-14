# =========
# = Notes =
# =========

# The phusion guys have made it so that you can install nginx and passenger in one 
# fell swoop, it is for this reason and cleanliness that I haven't decided to install
# nginx and passenger separately, otherwise nginx ends up being dependent on passenger
# so that it can call --add-module within its configure statement - That in itself would
# be strange. 

package :nginx, :provides => :webserver do
  puts "Nginx installed by passenger"
end

package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  version '2.2.3'
  
  gem 'passenger', :version => version do
    # Install nginx and the module
    post :install, "sudo passenger-install-nginx-module --auto --auto-download --prefix=/usr/local/nginx"
    
    post :install do
      # Install nginx init.d script
      #push_text File.read(File.join(File.dirname(__FILE__), 'nginx', 'init.d')), "/etc/init.d/nginx", :sudo => true
    end
    
    #post :install, "sudo chmod +x /etc/init.d/nginx"
    #post :install, "sudo /usr/sbin/update-rc.d -f nginx defaults"
    #post :install, "sudo /etc/init.d/nginx start"
  end
  
  requires :ruby_enterprise
  recommends :passenger_binaries
  
  #verify do
  #  has_executable "/usr/local/nginx/sbin/nginx"
  #  has_gem "passenger", version
  #end
end