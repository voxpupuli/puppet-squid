# @summary 
#   Defines icp_access entries for a squid server.
# @see http://www.squid-cache.org/Doc/config/icp_access/
# @example
#   squid::icp_access { 'our_networks hosts':
#     action => 'allow',
#   }
#
#   Adds a squid.conf line
#   icp_access allow our_networks hosts
#
# @param [Enum['allow', 'deny']] action 
#   Must be `deny` or `allow`. By default it is allow. The squid.conf file is ordered so by default
#   all allows appear before all denys. This can be overidden with the `order` parameter.
# @param [String] order 
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
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
