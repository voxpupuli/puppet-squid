class squid::config (
  $config                        = $::squid::config,
  $config_user                   = $::squid::config_user,
  $config_group                  = $::squid::config_group,
  $cache_mem                     = $::squid::cache_mem,
  $memory_cache_shared           = $::squid::memory_cache_shared,
  $maximum_object_size_in_memory = $::squid::maximum_object_size_in_memory,
  $access_log                    = $::squid::access_log,
  $coredump_dir                  = $::squid::coredump_dir,
  $max_filedescriptors           = $::squid::max_filedescriptors,
  $workers                       = $::squid::workers,
  $acls                          = $::squid::acls,
  $http_access                   = $::squid::http_access,
  $icp_access                    = $::squid::icp_access,
  $auth_params                   = $::squid::auth_params,
  $http_ports                    = $::squid::http_ports,
  $https_ports                   = $::squid::https_ports,
  $refresh_patterns              = $::squid::refresh_patterns,
  $snmp_ports                    = $::squid::snmp_ports,
  $ssl_bump                      = $::squid::ssl_bump,
  $sslproxy_cert_error           = $::squid::sslproxy_cert_error,
  $cache_dirs                    = $::squid::cache_dirs,
  $extra_config_sections         = $::squid::extra_config_sections,
) inherits squid {

  concat{$config:
    ensure => present,
    owner  => $config_user,
    group  => $config_group,
    mode   => '0640',
  }

  concat::fragment{'squid_header':
    target  => $config,
    content => template('squid/squid.conf.header.erb'),
    order   => '01',
  }

  if $acls {
    create_resources('squid::acl', $acls)
  }
  if $http_access {
    create_resources('squid::http_access', $http_access)
  }
  if $icp_access {
    create_resources('squid::icp_access', $icp_access)
  }
  if $auth_params {
    create_resources('squid::auth_param', $auth_params)
  }
  if $http_ports {
    create_resources('squid::http_port', $http_ports)
  }
  if $https_ports {
    create_resources('squid::https_port', $https_ports)
  }
  if $snmp_ports {
    create_resources('squid::snmp_port', $snmp_ports)
  }
  if $cache_dirs {
    create_resources('squid::cache_dir', $cache_dirs)
  }
  if $refresh_patterns {
    create_resources('squid::refresh_pattern', $refresh_patterns)
  }
  if $ssl_bump {
    create_resources('squid::ssl_bump', $ssl_bump)
  }
  if $sslproxy_cert_error {
    create_resources('squid::sslproxy_cert_error', $sslproxy_cert_error)
  }
  create_resources('squid::extra_config_section', $extra_config_sections)
}
