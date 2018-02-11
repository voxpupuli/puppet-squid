class squid::snmp_listen_ip (
  String            $listen_ip,
  String            $options        = '',
  String            $order          = '05',
) {

  concat::fragment{"squid_snmp_listen_ip_${listen_ip}":
    target  => $squid::config,
    content => template('squid/squid.conf.snmp_listen_ip.erb'),
    order   => "40-${order}",
  }

}
