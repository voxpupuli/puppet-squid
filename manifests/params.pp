# @summary 
#   This class manages Squid parameters
# @api
#   private
class squid::params {

  $ensure_service                = 'running'
  $enable_service                = true
  $cache_mem                     = '256 MB'
  $visible_hostname              = undef
  $via                           = undef
  $httpd_suppress_version_string = undef
  $forwarded_for                 = undef
  $memory_cache_shared           = undef
  $cache_replacement_policy      = undef
  $memory_replacement_policy     = undef
  $maximum_object_size_in_memory = '512 KB'
  $coredump_dir                  = undef
  $max_filedescriptors           = undef
  $workers                       = undef
  $acls                          = undef
  $cache                         = undef
  $http_access                   = undef
  $send_hit                      = undef
  $icp_access                    = undef
  $auth_params                   = undef
  $http_ports                    = undef
  $https_ports                   = undef
  $url_rewrite_program           = undef
  $url_rewrite_children          = undef
  $url_rewrite_child_options     = undef
  $refresh_patterns              = undef
  $snmp_incoming_address         = undef
  $snmp_ports                    = undef
  $snmp_access                   = undef
  $ssl_bump                      = undef
  $sslproxy_cert_error           = undef
  $cache_dirs                    = undef
  $buffered_logs                 = undef
  $logformat                     = undef
  $error_directory               = undef
  $err_page_stylesheet           = undef
  $service_restart               = undef
  $package_ensure                = 'present'

  case $facts['os']['name'] {
    /^(Debian|Ubuntu)$/: {
      case $facts['os']['release']['full'] {
        /^(8.*|14\.04)$/: {
          $package_name          = 'squid3'
          $service_name          = 'squid3'
          $config                = '/etc/squid3/squid.conf'
          $access_log            = 'daemon:/var/log/squid3/access.log squid'
          $squid_bin_path        = '/usr/sbin/squid3'
        }
        default: {
          $package_name          = 'squid'
          $service_name          = 'squid'
          $config                = '/etc/squid/squid.conf'
          $access_log            = 'daemon:/var/log/squid/access.log squid'
          $squid_bin_path        = '/usr/sbin/squid'
        }
      }

      $config_user           = 'root'
      $config_group          = 'root'
      $daemon_user           = 'proxy'
      $daemon_group          = 'proxy'
    }
    'FreeBSD': {
      $package_name              = 'squid'
      $service_name              = 'squid'
      $config                    = '/usr/local/etc/squid/squid.conf'
      $config_user               = 'root'
      $config_group              = 'squid'
      $access_log                = 'daemon:/var/log/squid/access.log squid'
      $daemon_user               = 'squid'
      $daemon_group              = 'squid'
      $squid_bin_path            = '/usr/sbin/squid'
    }
    default: {
      $package_name              = 'squid'
      $service_name              = 'squid'
      $config                    = '/etc/squid/squid.conf'
      $config_user               = 'root'
      $config_group              = 'squid'
      $access_log                = 'daemon:/var/log/squid/access.log squid'
      $daemon_user               = 'squid'
      $daemon_group              = 'squid'
      $squid_bin_path            = '/usr/sbin/squid'
    }
  }
}
