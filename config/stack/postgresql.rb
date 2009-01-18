package :postgres, :provides => :database do
  description 'PostgreSQL database'
  apt %w( postgresql postgresql-client libpq-dev )
  
  verify do
    has_executable 'psql'
  end
end
 
package :postgresql_driver, :provides => :database_driver do
  description 'Ruby PostgreSQL database driver'
  gem 'postgres'
  
  requires :ruby_enterprise
end
