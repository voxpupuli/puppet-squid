define squid::cache (
  Enum['allow', 'deny']
          $action  = 'allow',
  String  $value   = $title,
  String  $order   = '05',
  String  $comment = "cache fragment for ${value}"
) {

  concat::fragment{"squid_cache_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.cache.erb'),
    order   => "21-${order}-${action}",
  }

}
