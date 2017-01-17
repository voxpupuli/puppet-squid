define squid::extra_config_section (
  $comment = $title,
  $config_entries = {},
  $order   = '60',
) {

  validate_string($comment)
  
  if is_array($config_entries) {
    each($config_entries) |$single_entry| {
      validate_hash($single_entry)
    }
  } else {
    validate_hash($config_entries)
  }

  concat::fragment{"squid_extra_config_section_${comment}":
    target  => $::squid::config,
    content => template('squid/squid.conf.extra_config_section.erb'),
    order   => "${order}-${comment}",
  }

}