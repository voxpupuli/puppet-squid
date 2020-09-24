# @summary 
#   Defines https_port entries for a squid server. Results are the same with http_port and ssl set to `true`.
# @see 
#   http://www.squid-cache.org/Doc/config/https_port/
# @param port 
#   defaults to the namevar and is the port number.
# @param options 
#   A string to specify any options to add to the https_port line.  Defaults to an empty string.
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
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
