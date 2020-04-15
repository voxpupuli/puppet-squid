# Define Type squid::send\_hit
# Defines [send_hit](http://www.squid-cache.org/Doc/config/send_hit/) for a squid server.
# 
# squid:::send_hit{'PragmaNoCache':
#   action => 'deny',
# }
#
# Adds a squid.conf line
# send_hit deny PragmaNoCache
#
# Parameters for Type squid::send\hit
# value: defaults to the `namevar`. The rule to allow or deny.
# action: must one of `deny` or `allow`
# order: by default is 05.
# comment: A comment to add to the configuration file.
define squid::send_hit (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "send_hit fragment for ${value}"
) {

  concat::fragment{"squid_send_hit_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.send_hit.erb'),
    order   => "21-${order}-${action}",
  }

}
