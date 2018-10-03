class squid (
  String            $access_log                       = $squid::params::access_log,
  Pattern[/\d+ MB/] $cache_mem                        = $squid::params::cache_mem,
  String            $config                           = $squid::params::config,
  String            $config_group                     = $squid::params::config_group,
  String            $config_user                      = $squid::params::config_user,
  String            $daemon_group                     = $squid::params::daemon_group,
  String            $daemon_user                      = $squid::params::daemon_user,
  Boolean           $enable_service                   = $squid::params::enable_service,
  String            $ensure_service                   = $squid::params::ensure_service,
  Pattern[/\d+ KB/] $maximum_object_size_in_memory    = $squid::params::maximum_object_size_in_memory,
  String            $package_name                     = $squid::params::package_name,
  String            $package_ensure                   = $squid::params::package_ensure,
  String            $service_name                     = $squid::params::service_name,
  Optional[Stdlib::Absolutepath] $error_directory     = $squid::params::error_directory,
  Optional[Stdlib::Absolutepath] $err_page_stylesheet = $squid::params::err_page_stylesheet,
  Optional[String]  $cache_replacement_policy      = $squid::params::cache_replacement_policy,
  Optional[String]  $memory_replacement_policy     = $squid::params::memory_replacement_policy,
  Optional[Boolean] $httpd_suppress_version_string = $squid::params::httpd_suppress_version_string,
  Optional[Boolean] $forwarded_for                 = $squid::params::forwarded_for,
  Optional[String]  $visible_hostname              = $squid::params::visible_hostname,
  Optional[Boolean] $via                           = $squid::params::via,
  Optional[Hash]    $acls                          = $squid::params::acls,
  Optional[Hash]    $auth_params                   = $squid::params::auth_params,
  Optional[Hash]    $cache_dirs                    = $squid::params::cache_dirs,
  Optional[Hash]    $cache                         = $squid::params::cache,
  Optional[String]  $coredump_dir                  = $squid::params::coredump_dir,
  Optional[Hash]    $url_rewrite_program           = $squid::params::url_rewrite_program,
  Optional[Hash]    $extra_config_sections         = {},
  Optional[Hash]    $http_access                   = $squid::params::http_access,
  Optional[Hash]    $send_hit                      = $squid::params::send_hit,
  Optional[Hash]    $snmp_access                   = $squid::params::snmp_access,
  Optional[Hash]    $http_ports                    = $squid::params::http_ports,
  Optional[Hash]    $https_ports                   = $squid::params::https_ports,
  Optional[Hash]    $icp_access                    = $squid::params::icp_access,
  Optional[String]  $logformat                     = $squid::params::logformat,
  Optional[Boolean] $buffered_logs                 = $squid::params::buffered_logs,
  Optional[Integer] $max_filedescriptors           = $squid::params::max_filedescriptors,
  Optional[Variant[Enum['on', 'off'], Boolean]]
                    $memory_cache_shared              = $squid::params::memory_cache_shared,
  Optional[Hash]    $refresh_patterns                 = $squid::params::refresh_patterns,
  Optional[Stdlib::Compat::Ip_address]
                    $snmp_incoming_address            = $squid::params::snmp_incoming_address,
  Optional[Hash]    $snmp_ports                       = $squid::params::snmp_ports,
  Optional[Hash]    $ssl_bump                         = $squid::params::ssl_bump,
  Optional[Hash]    $sslproxy_cert_error              = $squid::params::sslproxy_cert_error,
  Optional[Integer] $workers                          = $squid::params::workers,
) inherits ::squid::params {

  anchor{'squid::begin':}
  -> class{'::squid::install':}
  -> class{'::squid::config':}
  ~> class{'::squid::service':}
  -> anchor{'squid::end':}

}
