# @summary 
#   Defines snmp_access entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/snmp_access/ 
# @example
#   squid::snmp_access { 'monitoring hosts':
#     action => 'allow',
#   }
#
#   Adds a squid.conf line
#   # snmp_access fragment for monitoring hosts
#   snmp_access allow monitoring hosts
#
# @example
#   squid::snmp_access { 'monitoring hosts':
#     action    => 'allow',
#     comment   => 'Our monitoring hosts are allowed',
#   }
#   Adds a squid.conf line:
#   # Our monitoring hosts are allowed
#   snmp_access allow monitoring hosts
#
# @param [Enum['allow', 'deny']] action
#   Allow or deny access for $title
# @param [String] order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
# @param [String] comment
#   snmp_access entry's preceding comment
define squid::snmp_access (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "snmp_access fragment for ${value}"
) {

  concat::fragment{"squid_snmp_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.snmp_access.erb'),
    order   => "20-${order}-${action}",
  }

}
