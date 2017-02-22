define squid::acl (
  $type,
  $aclname = $title,
  $entries = [],
  $order   = '05',
  $comment = "acl fragment for ${aclname}",

) {

  validate_string($type)
  validate_string($aclname)
  validate_string($comment)
  validate_array($entries)


  concat::fragment{"squid_acl_${aclname}":
    target  => $::squid::config,
    content => template('squid/squid.conf.acl.erb'),
    order   => "10-${order}-${type}",
  }

}
