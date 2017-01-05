define squid::sslproxy_cert_error (
  $action = 'allow',
  $value  = $title,
  $order   = '05',
) {

  validate_re($action,['^allow$','^deny$'])
  validate_string($value)


  concat::fragment{"squid_sslproxy_cert_error_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.sslproxy_cert_error.erb'),
    order   => "35-${order}-${action}",
  }

}
