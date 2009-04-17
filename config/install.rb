$:<< File.join(File.dirname(__FILE__), 'stack')

# ===============
# = Web servers = 
# ===============

# Apache and Nginx are interchangable simply by choosing which file should be included to the stack

# Apache has some extra installers for etags, gzip/deflate compression and expires headers.
# These are enabled by default when you choose Apache, you can remove these dependencies within
# stack/apache.rb

require 'apache'
# require 'nginx'

# Require the rest of our stack
%w(essential scm ruby_enterprise memcached postgresql mysql).each(&method(:require))

# What we're installing to your server
# Take what you want, leave what you don't
# Build up your own and strip down your server until you get it right. 
policy :stack, :roles => :app do
  requires :webserver               # Apache or Nginx
  requires :appserver               # Passenger
  requires :ruby_enterprise         # Ruby Enterprise edition
  requires :database                # MySQL or Postgres, also installs rubygems for each
  requires :scm                     # Git
  requires :memcached               # Memcached
  requires :libmemcached            # Libmemcached
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'deploy'
    end
  end
 
  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end

# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', ">= 0.2.3" 
rescue Gem::LoadError
  puts "sprinkle 0.2.3 required.\n Run: `sudo gem install sprinkle`"
  exit
end