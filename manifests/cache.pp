# @summary
#   Defines cache entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/cache/
# @example
#   squid::cache { 'our_network_hosts_acl':
#     action    => 'deny',
#     comment   => 'Our networks hosts are denied for caching',
#   }
#
#   Adds a squid.conf line:
#   #Our networks hosts denied for caching
#   cache deny our_network_hosts_acl
# @param action
#   Allow/deny caching for $title
# @param comment
#   Cache entry's preceding comment
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
define squid::cache (
  Enum['allow', 'deny'] $action = 'allow',
  String $value   = $title,
  String $order   = '05',
  String $comment = "cache fragment for ${value}"
) {
  concat::fragment { "squid_cache_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.cache.erb'),
    order   => "21-${order}-${action}",
  }
}
