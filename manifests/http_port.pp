define squid::http_port (
  Optional[Stdlib::Port] $port    = undef,
  Optional[Stdlib::Host] $host    = undef,
  Boolean                $ssl     = false,
  String                 $options = '',
  String                 $order   = '05',
) {
  $_title = String($title)

  # Try to extract host/port from title if neither were specified as
  # parameters. Allowed formats: host:port and port.
  if $host == undef and $port == undef and $_title =~ /^(?:(.+):)?(\d+)$/ {
    $_host = $1
    if $_host !~ Optional[Stdlib::Host] {
      fail("invalid host \"${_host}\" determined from title")
    }

    $_port = Integer($2)
    if $_port !~ Stdlib::Port {
      fail("invalid port \"${_port}\" determined from title")
    }
  } else {
    $_host = $host
    $_port = $port
  }

  if $_port == undef {
    fail('port parameter was not specified and could not be determined from title')
  }

  if $_host != undef {
    $_host_port = "${_host}:${_port}"
  } else {
    $_host_port = String($_port)
  }

  $protocol = $ssl ? {
    true    => 'https',
    default => 'http',
  }

  concat::fragment{"squid_${protocol}_port_${_title}":
    target  => $squid::config,
    content => epp('squid/squid.conf.port.epp', {
      title     => $_title,
      protocol  => $protocol,
      host_port => $_host_port,
      options   => $options,
    }),
    order   => "30-${order}",
  }

  if $facts['selinux'] == true {
    selinux::port{"selinux port squid_port_t ${_port}":
      ensure   => 'present',
      seltype  => 'squid_port_t',
      protocol => 'tcp',
      port     => $_port,
    }
  }

}
