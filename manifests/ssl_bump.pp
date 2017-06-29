define squid::ssl_bump (
  Enum[
    'bump',
    'client-first',
    'none',
    'peek',
    'peek-and-splice',
    'server-first',
    'splice',
    'stare',
    'terminate']
          $action = 'bump',
  String  $value  = $title,
  String  $order  = '05',
) {

  concat::fragment{"squid_ssl_bump_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.ssl_bump.erb'),
    order   => "25-${order}-${action}",
  }

}
