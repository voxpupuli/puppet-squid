define squid::auth_param (
  Enum['basic', 'digest']
          $scheme,
  Array   $entries,
  String  $auth_param_name = $title,
  String  $order           = '40',
) {

  concat::fragment{"squid_auth_param_${auth_param_name}":
    target  => $::squid::config,
    content => template('squid/squid.conf.auth_param.erb'),
    order   => "05-${order}-${scheme}",
  }

}
