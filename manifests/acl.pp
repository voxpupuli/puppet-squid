# @summary 
#   Defines acl entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/acl/
# @example create an ACL 'remote_urls' containing two entries
#   squid::acl { 'remote_urls':
#      type    => 'url_regex',
#      entries => ['http://example.org/path',
#                  'http://example.com/anotherpath'],
#   }
#
# @param type 
#   The acltype of the acl, must be defined, e.g url_regex, urlpath_regex, port, ..
# @param aclname 
#   The name of acl, defaults to the `title`.
# @param entries 
#   An array of acl entries, multiple members results in multiple lines in squid.conf.
# @param order 
#   Each ACL has an order `05` by default this can be specified if order of ACL definition matters.
define squid::acl (
  String $type,
  String $aclname = $title,
  Array  $entries = [],
  String $order   = '05',
  String $comment = "acl fragment for ${aclname}",
) {

  $type_cleaned = regsubst($type,':','','G')

  concat::fragment{"squid_acl_${aclname}":
    target  => $squid::config,
    content => template('squid/squid.conf.acl.erb'),
    order   => "10-${order}-${type_cleaned}",
  }

}
