# Defined Type squid::ssl\_bump
# Defines [ssl_bump entries](http://www.squid-cache.org/Doc/config/ssl_bump/) for a squid server.
# 
# squid::ssl_bump { 'all':
#   action => 'bump',
# }
# 
# Adds a squid.conf line
# 
# ssl_bump bump all
# 
# These may be defined as a hash passed to ::squid
# 
# Parameters for Type squid::ssl\_bump
# value: The type of the ssl_bump, must be defined, e.g bump, peek, ..
# action: The name of acl, defaults to `bump`.
# order: by default is `05`
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

  concat::fragment{"squid_ssl_bump_${action}_${value}":
    target  => $squid::config,
    content => template('squid/squid.conf.ssl_bump.erb'),
    order   => "25-${order}-${action}",
  }

}
