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
