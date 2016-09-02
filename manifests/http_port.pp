define squid::http_port (
  $port    = $title,
  $ssl     = false,
  $options = '',
  $order   = '05',
) {

  validate_bool($ssl)
  validate_integer($port)
  validate_string($options)

  $protocol = $ssl ? {
    true    => 'https',
    default => 'http',
  }

  concat::fragment{"squid_${protocol}_port_${port}":
    target  => $squid::config,
    content => template('squid/squid.conf.port.erb'),
    order   => "30-${order}",
  }

}
