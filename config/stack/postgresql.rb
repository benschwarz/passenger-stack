package :postgres, :provides => :database do
  description 'PostgreSQL database'
  apt %w( postgresql postgresql-client libpq-dev )
  
  verify do
    has_executable 'psql'
  end
  requires :postgresql_driver
end
 
package :postgresql_driver do
  description 'Ruby PostgreSQL database driver'
  gem 'postgres'
  
  requires :ruby_enterprise
end
