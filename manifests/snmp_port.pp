define squid::snmp_port (
  Variant[Pattern[/\d+/], Integer]
                    $port           = $title,
  String            $options        = '',
  String            $order          = '05',
  Optional[Integer] $process_number = undef,
) {

  concat::fragment{"squid_snmp_port_${port}":
    target  => $squid::config,
    content => template('squid/squid.conf.snmp_port.erb'),
    order   => "40-${order}",
  }

}
