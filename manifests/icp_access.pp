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
