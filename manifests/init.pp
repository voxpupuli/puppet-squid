# @summary
#   Module for configuring the squid caching service.
#   The module will set the SELINUX-context for the cache_dir and port, needs puppet-selinux
#
# @example The set up a simple squid server with a cache to forward http port 80 requests.
#   class { 'squid': }
#   squid::acl { 'Safe_ports':
#     type    => port,
#     entries => ['80'],
#   }
#   squid::http_access { 'Safe_ports':
#     action => allow,
#   }
#   squid::http_access{ '!Safe_ports':
#     action => deny,
#   }
#
# @param ensure_service
#   The ensure value of the squid service, defaults to `running`.
# @param enable_service
#   The enable value of the squid service, defaults to `true`.
# @param config
#   Location of squid.conf file, defaults to `/etc/squid/squid.conf`.
# @param config_user
#   User which owns the config file, default depends on `$operatingsystem`
# @param config_group
#   Group which owns the config file, default depends on `$operatingsystem`
# @param daemon_user
#   User which runs the squid daemon, this is used for ownership of the cache directory, default depends on `$operatingsystem`
# @param daemon_group
#   Group which runs the squid daemon, this is used for ownership of the cache directory, default depends on `$operatingsystem`
# @param cache_mem
#   Defaults to `256 MB`. http://www.squid-cache.org/Doc/config/cache_mem/
# @param cache_replacement_policy
#   Defaults to undef. http://www.squid-cache.org/Doc/config/cache_replacement_policy/
# @param memory_replacement_policy
#   Defaults to undef. http://www.squid-cache.org/Doc/config/memory_replacement_policy/
# @param memory_cache_shared
#   Defaults to undef. http://www.squid-cache.org/Doc/config/memory_cache_shared/.
# @param maximum_object_size_in_memory
#   Defaults to `512 KB`. http://www.squid-cache.org/Doc/config/maximum_object_size_in_memory/
# @param url_rewrite_program
#   Defaults to undef http://www.squid-cache.org/Doc/config/url_rewrite_program/
# @param url_rewrite_children
#   Defaults to undef http://www.squid-cache.org/Doc/config/url_rewrite_children/
# @param url_rewrite_child_options
#   Defaults to undef http://www.squid-cache.org/Doc/config/url_rewrite_children/
# @param access_log
#   Defaults to `daemon:/var/logs/squid/access.log squid`.  May be passed an Array.  http://www.squid-cache.org/Doc/config/access_log/
# @param coredump_dir
#   Defaults to undef. http://www.squid-cache.org/Doc/config/coredump_dir/
# @param error_directory
#   Defaults to undef. http://www.squid-cache.org/Doc/config/error_directory/
# @param err_page_stylesheet
#   Defaults to undef. http://www.squid-cache.org/Doc/config/err_page_stylesheet/
# @param package_name
#   Name of the squid package to manage, default depends on `$operatingsystem`
# @param package_ensure
#   Package status and/or version, default to present
# @param service_name
#   Name of the squid service to manage, default depends on `$operatingsystem`
# @param max_filedescriptors
#   Defaults to undef. http://www.squid-cache.org/Doc/config/max_filedescriptors/
# @param workers
#   Defaults to undef. http://www.squid-cache.org/Doc/config/workers/
# @param snmp_incoming_address
#   Defaults to undef. Can be set to an IP address to only listen for snmp requests on an individual interface. http://www.squid-cache.org/Doc/config/snmp_incoming_address/
# @param buffered_logs
#   Defaults to undef. http://www.squid-cache.org/Doc/config/buffered_logs/
# @param acls
#   Defaults to undef. If you pass in a hash of acl entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/acl/
# @param visible_hostname
#   Defaults to undef. http://www.squid-cache.org/Doc/config/visible_hostname/
# @param via
#   Defaults to undef. http://www.squid-cache.org/Doc/config/via/
# @param httpd_suppress_version_string
#   Defaults to undef. http://www.squid-cache.org/Doc/config/httpd_suppress_version_string/
# @param forwarded_for
#   Defaults to undef. supported values are "on", "off", "transparent", "delete", "truncate". http://www.squid-cache.org/Doc/config/forwarded_for/
# @param http_access
#   Defaults to undef. If you pass in a hash of http_access entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/http_access/
# @param http_ports
#   Defaults to undef. If you pass in a hash of http_port entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/http_port/
# @param https_ports
#   Defaults to undef. If you pass in a hash of https_port entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/https_port/
# @param icp_access
#   Defaults to undef. If you pass in a hash of icp_access entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/icp_access/
# @param refresh_patterns
#   Defaults to undef.  If you pass a hash of refresh_pattern entires, they will be defined automatically. http://www.squid-cache.org/Doc/config/refresh_pattern/
# @param snmp_ports
#   Defaults to undef. If you pass in a hash of snmp_port entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/snmp_port/
# @param send_hit
#   Defaults to undef. If you pass in a hash of send_hit entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/send_hit/
# @param cache_dirs
#   Defaults to undef. If you pass in a hash of cache_dir entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/cache_dir/
# @param ssl_bump
#   Defaults to undef. If you pass in a hash of ssl_bump entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/ssl_bump/
# @param sslproxy_cert_error
#   Defaults to undef. If you pass in a hash of sslproxy_cert_error entries, they will be defined automatically. http://www.squid-cache.org/Doc/config/sslproxy_cert_error/
# @param extra_config_sections
#   Defaults to empty hash. If you pass in a hash of `extra_config_section` resources, they will be defined automatically.
# @param service_restart
#   Defaults to undef. Overrides service resource restart command to be executed.
#   It can be used to perform a soft reload of the squid service.
# @param squid_bin_path
#   Path to the squid binary, default depends on `$operatingsystem`
# @example
#   class { 'squid':
#     cache_mem    => '512 MB',
#     workers      => 3,
#     coredump_dir => '/var/spool/squid',
#   }
#
# @example
#   class { 'squid':
#     cache_mem                 => '512 MB',
#     workers                   => 3,
#     coredump_dir              => '/var/spool/squid',
#     acls                      => { 'remote_urls' => {
#                                      type    => 'url_regex',
#                                      entries => ['http://example.org/path',
#                                                  'http://example.com/anotherpath'],
#                                    },
#                                  },
#     http_access               => { 'our_networks hosts' => { action => 'allow', }},
#     http_ports                => { '10000' => { options => 'accel vhost', }},
#     snmp_ports                => { '1000' => { process_number => 3, }},
#     cache_dirs                => { '/data/' => { type => 'ufs', options => '15000 32 256 min-size=32769', process_number => 2 }},
#     url_rewrite_program       => '/usr/bin/squidguard -c /etc/squidguard/squidguard.conf',
#     url_rewrite_children      => 12,
#     url_rewrite_child_options => startup=1,
#   }
class squid (
  Variant[String, Array[String]] $access_log          = $squid::params::access_log,
  Squid::Size       $cache_mem                        = $squid::params::cache_mem,
  String            $config                           = $squid::params::config,
  String            $config_group                     = $squid::params::config_group,
  String            $config_user                      = $squid::params::config_user,
  String            $daemon_group                     = $squid::params::daemon_group,
  String            $daemon_user                      = $squid::params::daemon_user,
  Boolean           $enable_service                   = $squid::params::enable_service,
  String            $ensure_service                   = $squid::params::ensure_service,
  Squid::Size       $maximum_object_size_in_memory    = $squid::params::maximum_object_size_in_memory,
  String            $package_name                     = $squid::params::package_name,
  Squid::PkgEnsure  $package_ensure                   = $squid::params::package_ensure,
  String            $service_name                     = $squid::params::service_name,
  Stdlib::Absolutepath $squid_bin_path                = $squid::params::squid_bin_path,
  Optional[Stdlib::Absolutepath] $error_directory     = $squid::params::error_directory,
  Optional[Stdlib::Absolutepath] $err_page_stylesheet = $squid::params::err_page_stylesheet,
  Optional[String]  $cache_replacement_policy      = $squid::params::cache_replacement_policy,
  Optional[String]  $memory_replacement_policy     = $squid::params::memory_replacement_policy,
  Optional[Boolean] $httpd_suppress_version_string = $squid::params::httpd_suppress_version_string,
  Optional[Variant[Enum['on', 'off', 'transparent', 'delete', 'truncate'], Boolean]] $forwarded_for = $squid::params::forwarded_for,
  Optional[String]  $visible_hostname              = $squid::params::visible_hostname,
  Optional[Boolean] $via                           = $squid::params::via,
  Optional[Hash]    $acls                          = $squid::params::acls,
  Optional[Hash]    $auth_params                   = $squid::params::auth_params,
  Optional[Hash]    $cache_dirs                    = $squid::params::cache_dirs,
  Optional[Hash]    $cache                         = $squid::params::cache,
  Optional[String]  $coredump_dir                  = $squid::params::coredump_dir,
  Optional[String]  $url_rewrite_program           = $squid::params::url_rewrite_program,
  Optional[Integer] $url_rewrite_children          = $squid::params::url_rewrite_children,
  Optional[String]  $url_rewrite_child_options     = $squid::params::url_rewrite_child_options,
  Hash              $extra_config_sections         = {},
  Optional[Hash]    $http_access                   = $squid::params::http_access,
  Optional[Hash]    $send_hit                      = $squid::params::send_hit,
  Optional[Hash]    $snmp_access                   = $squid::params::snmp_access,
  Optional[Hash]    $http_ports                    = $squid::params::http_ports,
  Optional[Hash]    $https_ports                   = $squid::params::https_ports,
  Optional[Hash]    $icp_access                    = $squid::params::icp_access,
  Optional[String]  $logformat                     = $squid::params::logformat,
  Optional[Boolean] $buffered_logs                 = $squid::params::buffered_logs,
  Optional[Integer] $max_filedescriptors           = $squid::params::max_filedescriptors,
  Optional[Variant[Enum['on', 'off'], Boolean]] $memory_cache_shared = $squid::params::memory_cache_shared,
  Optional[Hash]    $refresh_patterns              = $squid::params::refresh_patterns,
  Optional[Stdlib::Compat::Ip_address] $snmp_incoming_address = $squid::params::snmp_incoming_address,
  Optional[Hash]    $snmp_ports                    = $squid::params::snmp_ports,
  Optional[Hash]    $ssl_bump                      = $squid::params::ssl_bump,
  Optional[Hash]    $sslproxy_cert_error           = $squid::params::sslproxy_cert_error,
  Optional[Integer] $workers                       = $squid::params::workers,
  Optional[String]  $service_restart               = $squid::params::service_restart,
) inherits squid::params {
  contain squid::install
  contain squid::config
  contain squid::service

  Class['squid::install']
  -> Class['squid::config']
  ~> Class['squid::service']
}
