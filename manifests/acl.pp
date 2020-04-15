# Defines [acl entries](http://www.squid-cache.org/Doc/config/acl/) for a squid server.
# 
# squid::acl { 'remote_urls':
#    type    => 'url_regex',
#    entries => ['http://example.org/path',
#                'http://example.com/anotherpath'],
# }
# would result in a multi entry squid acl
# acl remote_urls url_regex http://example.org/path
# acl remote_urls url_regex http://example.com/anotherpath
#
# These may be defined as a hash passed to ::squid
# 
# Parameters for  Type squid::acl
# * type: The acltype of the acl, must be defined, e.g url_regex, urlpath_regex, port, ..
# * aclname: The name of acl, defaults to the `title`.
# * entries: An array of acl entries, multiple members results in multiple lines in squid.conf.
# * order: Each ACL has an order `05` by default this can be specified if order of ACL definition matters.
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
