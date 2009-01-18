package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient15-dev )
  
  verify do
    has_executable 'mysql'
  end
end
 
package :mysql_driver, :provides => :database_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql'
  
  requires :ruby_enterprise
end
