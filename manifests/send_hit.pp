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
