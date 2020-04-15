# Defined Type squid::http\_access
# Defines [http_access entries](http://www.squid-cache.org/Doc/config/http_access/) for a squid server.
# 
# squid::http_access { 'our_networks hosts':
#   action => 'allow',
# }
# 
# Adds a squid.conf line
# # http_access fragment for out_networks hosts
# http_access allow our_networks hosts
# 
# squid::http_access { 'our_networks hosts':
#   action    => 'allow',
#   comment   => 'Our networks hosts are allowed',
# }
#
# Adds a squid.conf line
# # Our networks hosts are allowed
# http_access allow our_networks hosts
define squid::http_access (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "http_access fragment for ${value}"
) {

  concat::fragment{"squid_http_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.http_access.erb'),
    order   => "20-${order}-${action}",
  }

}
