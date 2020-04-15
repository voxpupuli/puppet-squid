# Defined Type squid::cache
# Defines [cache entries](http://www.squid-cache.org/Doc/config/cache/) for a squid server.
# squid::cache { 'our_network_hosts_acl':
#   action    => 'deny',
#   comment   => 'Our networks hosts are denied for caching',
# }
#
# Adds a squid.conf line:
# Our networks hosts denied for caching
# cache deny our_network_hosts_acl
define squid::cache (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "cache fragment for ${value}"
) {

  concat::fragment{"squid_cache_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.cache.erb'),
    order   => "21-${order}-${action}",
  }

}
