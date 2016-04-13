define squid::http_access (
  $action = 'allow',
  $value  = $title,
  $order   = '05',
) {

  validate_re($action,['^allow$','^deny$'])
  validate_string($value)


  concat::fragment{"squid_http_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.http_access.erb'),
    order   => "20-${order}-${action}",
  }

}
