# @summary 
#   Defines snmp_port entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/snmp_port/ 
# @example
#   squid::snmp_port { '1000':
#     process_number => 3
#   }
#
#   Results in a squid configuration of
#   if ${process_number} = 3
#   snmp_port 1000
#   endif
#
# @param port 
#   Defaults to the namevar and is the port number.
# @param options 
#   A string to specify any options for the default. By default and empty string.
# @param process_number 
#   If set to and integer the snmp\_port is enabled only for a particular squid thread. Defaults to undef.
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
define squid::snmp_port (
  Variant[Pattern[/\d+/], Integer]
                    $port           = $title,
  String            $options        = '',
  String            $order          = '05',
  Optional[Integer] $process_number = undef,
) {
  concat::fragment { "squid_snmp_port_${port}":
    target  => $squid::config,
    content => template('squid/squid.conf.snmp_port.erb'),
    order   => "40-${order}",
  }
}
