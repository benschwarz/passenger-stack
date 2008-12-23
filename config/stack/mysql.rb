package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient15-dev )
end
 
package :mysql_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql'
  
  requires :ruby
end