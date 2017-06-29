define squid::cache_dir (
  String            $type           = ufs,
  String            $path           = $title,
  String            $options        = '',
  Optional[Integer] $process_number = undef,
  String            $order          = '05',
) {

  concat::fragment{"squid_cache_dir_${path}":
    target  => $squid::config,
    content => template('squid/squid.conf.cache_dir.erb'),
    order   => "50-${order}",
  }

  file{$path:
    ensure  => directory,
    owner   => $::squid::daemon_user,
    group   => $::squid::daemon_group,
    mode    => '0750',
    require => Package[$::squid::package_name],
  }

}
