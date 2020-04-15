# Defined Type Squid::Https\_port
# Defines [https_port entries](http://www.squid-cache.org/Doc/config/https_port/) for a squid server.
# As an alternative to using the Squid::Http\_port defined type with `ssl` set to `true`, you can use this type instead.  
# The result is the same. Internally this type uses Squid::Http\_port to create the configuration entries.
#
# Parameters for Type squid::https\_port
# * port: defaults to the namevar and is the port number.
# * options: A string to specify any options to add to the https_port line.  Defaults to an empty string.
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
