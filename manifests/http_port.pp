define squid::http_port (
  $port    = $title,
  $options = '',
  $order   = '05',
) {

  validate_integer($port)
  validate_string($options)

  concat::fragment{"squid_http_port_${port}":
    target  => $squid::config,
    content => template('squid/squid.conf.port.erb'),
    order   => "30-${order}",
  }

}
