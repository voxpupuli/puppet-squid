define squid::https_port (
  Variant[Pattern[/\d+/], Integer]
          $port    = $title,
  String  $options = '',
  String  $order   = '05',
) {

  squid::http_port { "${port}": # lint:ignore:only_variable_string
    ssl     => true,
    options => $options,
    order   => $order,
  }

}
