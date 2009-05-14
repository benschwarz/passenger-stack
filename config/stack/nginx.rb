package :nginx, :provides => :webserver do
  description "Nginx, red like communism"
  
  verify do
    has_binary "/usr/local/nginx"
  end
  
  requires :build_essential 
end