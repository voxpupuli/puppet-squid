class squid::config (
  $config                        = $squid::config,
  $cache_mem                     = $squid::cache_mem,
  $memory_cache_shared           = $squid::memory_cache_shared,
  $maximum_object_size_in_memory = $squid::maximum_object_size_in_memory,
  $access_log                    = $squid::access_log,
  $coredump_dir                  = $squid::coredump_dir,
  $max_filedescriptors           = $squid::max_filedescriptors,
  $workers                       = $squid::workers,
) inherits squid {

  concat{$config:
    ensure => present,
    owner  => root,
    group  => squid,
    mode   => '0640',
  }
 
  concat::fragment{'squid_header':
    target  => $config,
    content => template('squid/squid.conf.header.erb'),
    order   => '01',
  }
}
