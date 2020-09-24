# @summary 
#   Defines sslproxy_cert_error entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/sslproxy_cert_error/ 
# @example
#   squid::sslproxy_cert_error { 'all':
#     action => 'allow',
#   }
# 
#   Adds a squid.conf line
#   sslproxy_cert_error allow all
# 
# @param value 
#   Defaults to the `namevar` the rule to allow or deny.
# @param action 
#   Must be `deny` or `allow`. By default it is allow. The squid.conf file is ordered so by default
#   all allows appear before all denys. This can be overidden with the `order` parameter.
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
define squid::sslproxy_cert_error (
  Enum['allow', 'deny']
          $action = 'allow',
  String  $value  = $title,
  String  $order  = '05',
) {
  concat::fragment { "squid_sslproxy_cert_error_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.sslproxy_cert_error.erb'),
    order   => "35-${order}-${action}",
  }
}
