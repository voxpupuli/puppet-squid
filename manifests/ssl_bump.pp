# @summary 
#   Defines ssl_bump entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/ssl_bump/ 
# @example
#   squid::ssl_bump { 'all':
#     action => 'bump',
#   }
# 
#   Adds a squid.conf line
#   ssl_bump bump all
# 
# @param title 
#   The name of acl the ssl_bump rule is applied to
# @param action 
#   The type of the ssl_bump, must be defined, e.g bump, peek, ..
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
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
  concat::fragment { "squid_ssl_bump_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.ssl_bump.erb'),
    order   => "25-${order}-${action}",
  }
}
