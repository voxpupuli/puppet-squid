# @summary
#   Defines http_port entries for a squid server.
#   By setting optional `ssl` parameter to `true` will create https_port entries instead.
# @see
#   http://www.squid-cache.org/Doc/config/http_port/
# @example
#   squid::http_port { '10000':
#     options => 'accel vhost'
#   }
#   squid::http_port { '10001':
#     ssl     => true,
#     options => 'cert=/etc/squid/ssl_cert/server.cert key=/etc/squid/ssl_cert/server.key'
#   }
#   squid::http_port { '127.0.0.1:3128':
#   }
#
#   Results in a squid configuration of:
#   http_port 10000 accel vhost
#   https_port 10001 cert=/etc/squid/ssl_cert/server.cert key=/etc/squid/ssl_cert/server.key
#   http_port 127.0.0.1:3128
# @param title
#   The title/namevar may be in the form `port` or `host:port` to provide the below values. Otherwise,
#   specify `port` explicitly, and `host` if desired.
# @param port
#   Defaults to the port of the namevar and is the port number to listen on.
# @param host
#   Defaults to the host part of the namevar and is the interface to listen on. If not specified, Squid listens on all interfaces.
# @param options
#   A string to specify any options for the default. By default and empty string.
# @param ssl
#   When set to `true` creates https_port entries. Defaults to `false`.
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
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

  concat::fragment { "squid_${protocol}_port_${_title}":
    target  => $squid::config,
    content => epp('squid/squid.conf.port.epp',
      {
        title     => $_title,
        protocol  => $protocol,
        host_port => $_host_port,
        options   => $options,
      }
    ),
    order   => "30-${order}",
  }

  if fact('os.selinux.enabled') {
    ensure_resource('selinux::port', "selinux port squid_port_t ${_port}",
      {
        ensure   => 'present',
        seltype  => 'squid_port_t',
        protocol => 'tcp',
        port     => $_port,
      }
    )
  }
}
