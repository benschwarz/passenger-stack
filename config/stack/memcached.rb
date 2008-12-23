package :memcached_daemon, :provides => :memcached do
  description 'Memcached, a distributed memory object store'
  apt %w( memcached )
end

package :libmemcached do
  source 'http://download.tangent.org/libmemcached-0.25.tar.gz'
  requires :memcached
end