# @summary 
#   Defines http_access entries for a squid server.
# @see 
#   https://github.com/puppetlabs/puppetlabs-docker/blob/master/REFERENCE.md
# @example
#   squid::http_access { 'our_networks hosts':
#     action => 'allow',
#   }
# 
#   Adds a squid.conf line
#   # http_access fragment for out_networks hosts
#   http_access allow our_networks hosts
# 
# @example
#   squid::http_access { 'our_networks hosts':
#     action    => 'allow',
#     comment   => 'Our networks hosts are allowed',
#   }
#
#   Adds a squid.conf line
#   # Our networks hosts are allowed
#   http_access allow our_networks hosts
# @param title
#   The name of the ACL the rule is applied to
# @param action
#   allow or deny access for $title
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
# @param comment
#   http_access entry's preceding comment
define squid::http_access (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "http_access fragment for ${value}"
) {
  concat::fragment { "squid_http_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.http_access.erb'),
    order   => "20-${order}-${action}",
  }

}
