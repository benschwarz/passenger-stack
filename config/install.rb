# Require our stack
%w(essential server scm ruby_enterprise mysql memcached).each do |r|
  require "stack/#{r}"
end

policy :ffolio, :roles => :app do
  requires :ruby
  requires :appserver
  requires :database
  requires :webserver
  requires :scm 
  requires :memcached
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    recipes 'deploy'
  end
 
  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end