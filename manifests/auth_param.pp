# @summary 
#   Defines auth_param entries  for a squid server.
# @see 
#   http://www.squid-cache.org/Doc/config/auth_param/ 
# @example
#   squid::auth_param { 'basic auth_param':
#     scheme  => 'basic',
#     entries => [
#       'program /usr/lib64/squid/basic_ncsa_auth /etc/squid/.htpasswd',
#       'children 5',
#       'realm Squid Basic Authentication',
#       'credentialsttl 5 hours',
#     ],
#   }
#   would result in multi entry squid auth_param:
#   auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/.htpasswd
#   auth_param basic children 5
#   auth_param basic realm Squid Basic Authentication
#   auth_param basic credentialsttl 5 hours
# 
# @param scheme 
#   The scheme used for authentication must be defined. Valid values are 'basic', 'digest', 'negotiate' and 'ntlm'.
# @param entries 
#   An array of entries, multiple members results in multiple lines in squid.conf
# @param order 
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
define squid::auth_param (
  Enum['basic', 'digest', 'negotiate', 'ntlm']
          $scheme,
  Array   $entries,
  String  $auth_param_name = $title,
  String  $order           = '40',
) {
  concat::fragment{ "squid_auth_param_${auth_param_name}":
    target  => $squid::config,
    content => template('squid/squid.conf.auth_param.erb'),
    order   => "05-${order}-${scheme}",
  }

}
