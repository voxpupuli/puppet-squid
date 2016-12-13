class squid (
  $ensure_service                = $squid::params::ensure_service,
  $enable_service                = $squid::params::enable_service,
  $service_name                  = $squid::params::service_name,
  $config                        = $squid::params::config,
  $config_user                   = $squid::params::config_user,
  $config_group                  = $squid::params::config_group,
  $package_name                  = $squid::params::package_name,
  $cache_mem                     = $squid::params::cache_mem,
  $memory_cache_shared           = $squid::params::memory_cache_shared,
  $maximum_object_size_in_memory = $squid::params::maximum_object_size_in_memory,
  $logformat                     = $squid::params::logformat,
  $access_log                    = $squid::params::access_log,
  $coredump_dir                  = $squid::params::coredump_dir,
  $max_filedescriptors           = $squid::params::max_filedescriptors,
  $workers                       = $squid::params::workers,
  $acls                          = $squid::params::acls,
  $http_access                   = $squid::params::http_access,
  $icp_access                    = $squid::params::icp_access,
  $auth_params                   = $squid::params::auth_params,
  $http_ports                    = $squid::params::http_ports,
  $https_ports                   = $squid::params::https_ports,
  $snmp_ports                    = $squid::params::snmp_ports,
  $cache_dirs                    = $squid::params::cache_dirs,
  $daemon_user                   = $squid::params::daemon_user,
  $daemon_group                  = $squid::params::daemon_group,
  $extra_config_sections         = {},
) inherits ::squid::params {

  validate_string($ensure_service)
  validate_bool($enable_service)
  validate_re($cache_mem,'\d+ MB')
  validate_string($config)
  validate_string($config_user)
  validate_string($config_group)
  validate_string($daemon_user)
  validate_string($daemon_group)
  if $memory_cache_shared {
    validate_re($memory_cache_shared,['^on$','^off$'])
  }
  validate_re($maximum_object_size_in_memory,'\d+ KB')
  validate_string($logformat)
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
  if $icp_access {
    validate_hash($icp_access)
  }
  if $auth_params {
    validate_hash($auth_params)
  }
  if $http_ports {
    validate_hash($http_ports)
  }
  if $https_ports {
    validate_hash($https_ports)
  }
  if $snmp_ports {
    validate_hash($snmp_ports)
  }
  if $cache_dirs {
    validate_hash($cache_dirs)
  }

  validate_hash($extra_config_sections)

  anchor{'squid::begin':} ->
  class{'::squid::install':} ->
  class{'::squid::config':} ~>
  class{'::squid::service':} ->
  anchor{'squid::end':}

}
