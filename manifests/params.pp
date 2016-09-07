class squid::params {

  $ensure_service                = 'running'
  $enable_service                = true
  $config                        = '/etc/squid/squid.conf'
  $config_user                   = 'root'
  $config_group                  = 'squid'
  $cache_mem                     = '256 MB'
  $memory_cache_shared           = undef
  $maximum_object_size_in_memory = '512 KB'
  $access_log                    = 'daemon:/var/log/squid/access.log squid'
  $coredump_dir                  = undef
  $max_filedescriptors           = undef
  $workers                       = undef
  $acls                          = undef
  $http_access                   = undef
  $auth_params                   = undef
  $http_ports                    = undef
  $service_name                  = 'squid'
  $snmp_ports                    = undef
  $cache_dirs                    = undef
}
