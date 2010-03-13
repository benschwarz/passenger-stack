# =========
# = Notes =
# =========

# The phusion guys have made it so that you can install nginx and passenger in one 
# fell swoop, it is for this reason and cleanliness that I haven't decided to install
# nginx and passenger separately, otherwise nginx ends up being dependent on passenger
# so that it can call --add-module within its configure statement - That in itself would
# be strange. 

package :nginx, :provides => :webserver do
  puts "** Nginx installed by passenger gem **"
  requires :passenger
  
  push_text File.read(File.join(File.dirname(__FILE__), 'nginx', 'init.d')), "/etc/init.d/nginx", :sudo => true do
    post :install, "sudo chmod +x /etc/init.d/nginx"
    post :install, "sudo /usr/sbin/update-rc.d -f nginx defaults"
    post :install, "sudo /etc/init.d/nginx start"
  end
  
  verify do
    has_executable "/usr/local/nginx/sbin/nginx"
    has_file "/etc/init.d/nginx"
  end
end

package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  version '2.2.10'
  binaries = %w(passenger-config passenger-install-nginx-module passenger-install-apache2-module passenger-make-enterprisey passenger-memory-stats passenger-spawn-server passenger-status passenger-stress-test)
  
  gem 'passenger', :version => version do    
    # Install nginx and the module
    binaries.each {|bin| post :install, "ln -s #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}"}
    post :install, "sudo passenger-install-nginx-module --auto --auto-download --prefix=/usr/local/nginx"
  end
  
  requires :ruby_enterprise
  
  verify do
    has_gem "passenger", version
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end
end