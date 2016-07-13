define squid::cache_dir (
  $type           = ufs,
  $path           = $title,
  $options        = '',
  $process_number = undef,
  $order          = '05',
) {

  validate_string($type)
  validate_string($path)
  validate_string($options)
  if $process_number {
    validate_integer($process_number)
  }

  concat::fragment{"squid_cache_dir_${path}":
    target  => $squid::config,
    content => template('squid/squid.conf.cache_dir.erb'),
    order   => "50-${order}",
  }

  file{$path:
    ensure => directory,
    owner  => $::squid::daemon_user,
    group  => $::squid::daemon_group,
    mode   => '0750',
  }

}
