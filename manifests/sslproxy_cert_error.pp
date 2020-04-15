# Defined Type squid::sslproxy\_cert\_error
# Defines [sslproxy_cert_error entries](http://www.squid-cache.org/Doc/config/sslproxy_cert_error/) for a squid server.
# 
# squid::sslproxy_cert_error { 'all':
#   action => 'allow',
# }
# 
# Adds a squid.conf line
# 
# sslproxy_cert_error allow all
# 
# These may be defined as a hash passed to ::squid
# 
# Parameters for Type squid::sslproxy\_cert\_error
# value: defaults to the `namevar` the rule to allow or deny.
# action: must be `deny` or `allow`. By default it is allow. The squid.conf file is ordered so by default
#    all allows appear before all denys. This can be overidden with the `order` parameter.
# order: by default is `05`
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
