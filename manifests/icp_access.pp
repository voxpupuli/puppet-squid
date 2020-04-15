# Defined Type squid::icp\_access
# Defines [icp_access entries](http://www.squid-cache.org/Doc/config/icp_access/) for a squid server.
#
# squid::icp_access { 'our_networks hosts':
#   action => 'allow',
# }
#
# Adds a squid.conf line
#
# icp_access allow our_networks hosts
#
# These may be defined as a hash passed to ::squid
i#
# Parameters for Type squid::http\_allow
# * value: defaults to the `namevar` the rule to allow or deny.
# * action: must be `deny` or `allow`. By default it is allow. The squid.conf file is ordered so by default
#    all allows appear before all denys. This can be overidden with the `order` parameter.
# * order: by default is `05`
define squid::icp_access (
  Enum['allow', 'deny']
          $action = 'allow',
  String  $value  = $title,
  String  $order  = '05',
) {

  concat::fragment{"squid_icp_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.icp_access.erb'),
    order   => "30-${order}-${action}",
  }

}
