define squid::acl (
   $type ,
   $aclname = $title,
   $entries = [],
   $order   = '05',
) {

   validate_string($type)
   validate_string($aclname)
   validate_array($entries)


   concat::fragment{"squid_acl_${aclname}":
     target  => $squid::config,
     content => template('squid/squid.conf.acl.erb'),
     order   => "10-${order}-${type}"
   }

}
