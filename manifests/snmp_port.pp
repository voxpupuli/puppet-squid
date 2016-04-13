define squid::snmp_port (
  $port           = $title,
  $options        = '',
  $process_number = undef,
  $order          = '05',
) {

  validate_integer($port)
  validate_string($options)
  if $process_number {
    validate_integer($process_number)
  }

  concat::fragment{"squid_snmp_port_${port}":
    target  => $squid::config,
    content => template('squid/squid.conf.snmp_port.erb'),
    order   => "40-${order}",
  }

}
