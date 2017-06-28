define squid::refresh_pattern (
  Integer $max,
  Integer $min,
  Integer $percent,
  Boolean $case_sensitive = true,
  String  $options        = '',
  String  $order          = '05',
  String  $pattern        = $title,
  String  $comment        = "refresh_pattern fragment for ${pattern}",
) {

  concat::fragment{"squid_refresh_pattern_${pattern}":
    target  => $::squid::config,
    content => template('squid/squid.conf.refresh_pattern.erb'),
    order   => "45-${order}",
  }
}
