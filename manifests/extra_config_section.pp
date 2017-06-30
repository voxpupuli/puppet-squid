define squid::extra_config_section (
  String              $comment = $title,
  Variant[Array,Hash] $config_entries = {},
  String              $order   = '60',
) {

  concat::fragment{"squid_extra_config_section_${comment}":
    target  => $::squid::config,
    content => template('squid/squid.conf.extra_config_section.erb'),
    order   => "${order}-${comment}",
  }
}
