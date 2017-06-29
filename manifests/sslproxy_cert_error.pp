define squid::sslproxy_cert_error (
  Enum['allow', 'deny']
          $action = 'allow',
  String  $value  = $title,
  String  $order  = '05',
) {

  concat::fragment{"squid_sslproxy_cert_error_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.sslproxy_cert_error.erb'),
    order   => "35-${order}-${action}",
  }

}
