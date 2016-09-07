class squid (
  $ensure_service                = $squid::params::ensure_service,
  $enable_service                = $squid::params::enable_service,
  $config                        = $squid::params::config,
  $config_user                   = $squid::params::config_user,
  $config_group                  = $squid::params::config_group,
  $cache_mem                     = $squid::params::cache_mem,
  $memory_cache_shared           = $squid::params::memory_cache_shared,
  $maximum_object_size_in_memory = $squid::params::maximum_object_size_in_memory,
  $access_log                    = $squid::params::access_log,
  $coredump_dir                  = $squid::params::coredump_dir,
  $max_filedescriptors           = $squid::params::max_filedescriptors,
  $workers                       = $squid::params::workers,
  $acls                          = $squid::params::acls,
  $http_access                   = $squid::params::http_access,
  $auth_params                   = $squid::params::auth_params,
  $http_ports                    = $squid::params::http_ports,
  $service_name                  = $squid::params::service_name,
  $snmp_ports                    = $squid::params::snmp_ports,
  $cache_dirs                    = $squid::params::cache_dirs,
) inherits ::squid::params {

  validate_string($ensure_service)
  validate_bool($enable_service)
  validate_re($cache_mem,'\d+ MB')
  validate_string($config)
  if $memory_cache_shared {
    validate_re($memory_cache_shared,['^on$','^off$'])
  }
  validate_re($maximum_object_size_in_memory,'\d+ KB')
  validate_string($access_log)
  if $coredump_dir {
    validate_string($coredump_dir)
  }
  if $max_filedescriptors {
    validate_integer($max_filedescriptors)
  }
  if $workers {
    validate_integer($workers)
  }

  if $acls {
    validate_hash($acls)
  }
  if $http_access {
    validate_hash($http_access)
  }
  if $auth_params {
    validate_hash($auth_params)
  }
  if $http_ports {
    validate_hash($http_ports)
  }
  if $snmp_ports {
    validate_hash($snmp_ports)
  }
  if $cache_dirs {
    validate_hash($cache_dirs)
  }

  anchor{'squid::begin':} ->
  class{'::squid::install':} ->
  class{'::squid::config':} ~>
  class{'::squid::service':} ->
  anchor{'squid::end':}



}
