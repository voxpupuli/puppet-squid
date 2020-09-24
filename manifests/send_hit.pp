# @summary 
#   Defines send_hit for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/send_hit/
# @example
#   squid:::send_hit{'PragmaNoCache':
#     action => 'deny',
#   }
#
#   Adds the following squid.conf line:
#   send_hit deny PragmaNoCache
#
# @param value 
#   Defaults to the `namevar`. The rule to allow or deny.
# @param action 
#   Must one of `deny` or `allow`
# @param order 
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
# @param comment 
#   A preceeding comment to add to the configuration file.
define squid::send_hit (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "send_hit fragment for ${value}"
) {
  concat::fragment{ "squid_send_hit_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.send_hit.erb'),
    order   => "21-${order}-${action}",
  }

}
