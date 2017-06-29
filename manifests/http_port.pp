define squid::http_port (
  Variant[Pattern[/\d+/], Integer]
          $port    = $title,
  Boolean $ssl     = false,
  String  $options = '',
  String  $order   = '05',
) {

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
