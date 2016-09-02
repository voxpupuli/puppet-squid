define squid::https_port (
  $port    = $title,
  $options = '',
  $order   = '05',
) {

  validate_integer($port)
  validate_string($options)

  squid::http_port { "${port}": # lint:ignore:only_variable_string
    ssl     => true,
    options => $options,
    order   => $order,
  }

}
