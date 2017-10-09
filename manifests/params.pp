# Class: squid::params
#
# This class manages Squid parameters

class squid::params {

  $ensure_service                = 'running'
  $enable_service                = true

  $access_log                    = undef
  $acls                          = undef
  $auth_params                   = undef
  $cache_dirs                    = undef
  $cache_mem                     = undef
  $coredump_dir                  = undef
  $http_access                   = undef
  $http_ports                    = undef
  $https_ports                   = undef
  $icp_access                    = undef
  $logformat                     = undef
  $max_filedescriptors           = undef
  $maximum_object_size_in_memory = undef
  $memory_cache_shared           = undef
  $refresh_patterns              = undef
  $snmp_ports                    = undef
  $ssl_bump                      = undef
  $sslproxy_cert_error           = undef
  $workers                       = undef

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      case $::operatingsystemrelease {
        /^(8.*|14\.04)$/: {
          $package_name          = 'squid3'
          $service_name          = 'squid3'
          $config                = '/etc/squid3/squid.conf'
          $config_user           = 'root'
          $config_group          = 'root'
          $daemon_user           = 'proxy'
          $daemon_group          = 'proxy'
        }
        /^(9.*)$/: {
          $package_name          = 'squid3'
          $service_name          = 'squid'
          $config                = '/etc/squid/squid.conf'
          $config_user           = 'root'
          $config_group          = 'root'
          $daemon_user           = 'proxy'
          $daemon_group          = 'proxy'
        }
        /^16\.04$/: {
          $package_name          = 'squid'
          $service_name          = 'squid'
          $config                = '/etc/squid/squid.conf'
          $config_user           = 'root'
          $config_group          = 'root'
          $daemon_user           = 'proxy'
          $daemon_group          = 'proxy'
        }
        default: {
          $package_name          = 'squid'
          $service_name          = 'squid'
          $config                = '/etc/squid/squid.conf'
          $config_user           = 'root'
          $config_group          = 'squid'
          $daemon_user           = 'squid'
          $daemon_group          = 'squid'
        }
      }
    }
    'FreeBSD': {
      $package_name              = 'squid'
      $service_name              = 'squid'
      $config                    = '/usr/local/etc/squid/squid.conf'
      $config_user               = 'root'
      $config_group              = 'squid'
      $daemon_user               = 'squid'
      $daemon_group              = 'squid'
    }
    default: {
      $package_name              = 'squid'
      $service_name              = 'squid'
      $config                    = '/etc/squid/squid.conf'
      $config_user               = 'root'
      $config_group              = 'squid'
      $daemon_user               = 'squid'
      $daemon_group              = 'squid'
    }
  }
}
