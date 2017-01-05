define squid::ssl_bump (
  $action = 'bump',
  $value  = $title,
  $order   = '05',
) {

  validate_re($action,['^splice$','^bump$','^peek$','^stare$','^terminate$','^client-first$','^server-first$','^peek-and-splice$','^none$'])
  validate_string($value)


  concat::fragment{"squid_ssl_bump_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.ssl_bump.erb'),
    order   => "25-${order}-${action}",
  }

}
