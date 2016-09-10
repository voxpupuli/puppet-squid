define squid::auth_param (
  $scheme,
  $entries,
  $auth_param_name = $title,
  $order   = '40',
) {

  validate_string($scheme)
  validate_re($scheme,['^basic$','^digest$'])
  validate_string($auth_param_name)
  validate_array($entries)


  concat::fragment{"squid_auth_param_${auth_param_name}":
    target  => $::squid::config,
    content => template('squid/squid.conf.auth_param.erb'),
    order   => "05-${order}-${scheme}",
  }

}
