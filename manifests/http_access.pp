define squid::http_access (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "http_access fragment for ${value}"
) {

  concat::fragment{"squid_http_access_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.http_access.erb'),
    order   => "20-${order}-${action}",
  }

}
