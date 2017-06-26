class squid (
  String            $access_log                    = $squid::params::access_log,
  Pattern[/\d+ MB/] $cache_mem                     = $squid::params::cache_mem,
  String            $config                        = $squid::params::config,
  String            $config_group                  = $squid::params::config_group,
  String            $config_user                   = $squid::params::config_user,
  String            $daemon_group                  = $squid::params::daemon_group,
  String            $daemon_user                   = $squid::params::daemon_user,
  Boolean           $enable_service                = $squid::params::enable_service,
  String            $ensure_service                = $squid::params::ensure_service,
  Pattern[/\d+ KB/] $maximum_object_size_in_memory = $squid::params::maximum_object_size_in_memory,
  String            $package_name                  = $squid::params::package_name,
  String            $service_name                  = $squid::params::service_name,
  Optional[Hash]    $acls                          = $squid::params::acls,
  Optional[Hash]    $auth_params                   = $squid::params::auth_params,
  Optional[Hash]    $cache_dirs                    = $squid::params::cache_dirs,
  Optional[String]  $coredump_dir                  = $squid::params::coredump_dir,
  Optional[Hash]    $extra_config_sections         = {},
  Optional[Hash]    $http_access                   = $squid::params::http_access,
  Optional[Hash]    $http_ports                    = $squid::params::http_ports,
  Optional[Hash]    $https_ports                   = $squid::params::https_ports,
  Optional[Hash]    $icp_access                    = $squid::params::icp_access,
  Optional[String]  $logformat                     = $squid::params::logformat,
  Optional[Integer] $max_filedescriptors           = $squid::params::max_filedescriptors,
  Optional[Variant[Enum['on', 'off'], Boolean]]
                    $memory_cache_shared           = $squid::params::memory_cache_shared,
  Optional[Hash]    $refresh_patterns              = $squid::params::refresh_patterns,
  Optional[Hash]    $snmp_ports                    = $squid::params::snmp_ports,
  Optional[Hash]    $ssl_bump                      = $squid::params::ssl_bump,
  Optional[Hash]    $sslproxy_cert_error           = $squid::params::sslproxy_cert_error,
  Optional[Integer] $workers                       = $squid::params::workers,
) inherits ::squid::params {

  anchor{'squid::begin':}
  -> class{'::squid::install':}
  -> class{'::squid::config':}
  ~> class{'::squid::service':}
  -> anchor{'squid::end':}

}
