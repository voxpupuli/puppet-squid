define squid::acl (
  String $type,
  String $aclname = $title,
  Array  $entries = [],
  String $order   = '05',
  String $comment = "acl fragment for ${aclname}",
) {

  $type_cleaned = regsubst($type,':','','G')

  concat::fragment{"squid_acl_${aclname}":
    target  => $::squid::config,
    content => template('squid/squid.conf.acl.erb'),
    order   => "10-${order}-${type_cleaned}",
  }

}
