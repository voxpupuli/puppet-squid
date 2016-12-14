define squid::icp_access (
  $action = 'allow',
  $value  = $title,
  $order   = '05',
) {

  validate_re($action,['^allow$','^deny$'])
  validate_string($value)


  concat::fragment{"squid_icp_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.icp_access.erb'),
    order   => "30-${order}-${action}",
  }

}
