class squid::params {

  $config                        = '/etc/squid/squid.conf'
  $cache_mem                     = '256 MB'
  $memory_cache_shared           = undef
  $maximum_object_size_in_memory = '512 KB'
  $access_log                    = 'daemon:/var/logs/squid/access.log squid'
  $coredump_dir                  = undef
  $max_filedescriptors           = undef
  $workers                       = undef
}
