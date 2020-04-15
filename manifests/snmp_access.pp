# Defined Type squid::snmp\_access
# Defines [snmp_access entries](http://www.squid-cache.org/Doc/config/snmp_access/) for a squid server.

# squid::snmp_access { 'monitoring hosts':
#   action => 'allow',
# }
#
# Adds a squid.conf line
# 
# # snmp_access fragment for monitoring hosts
# snmp_access allow monitoring hosts

# squid::snmp_access { 'monitoring hosts':
#   action    => 'allow',
#   comment   => 'Our monitoring hosts are allowed',
# }

# Adds a squid.conf line

# # Our monitoring hosts are allowed
# snmp_access allow monitoring hosts
#
# These may be defined as a hash passed to ::squid
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
