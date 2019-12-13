define squid::cache_dir (
  String            $type           = ufs,
  String            $path           = $title,
  String            $options        = '',
  Optional[Integer] $process_number = undef,
  String            $order          = '05',
  Boolean           $manage_dir     = true,
) {

  concat::fragment{"squid_cache_dir_${path}":
    target  => $squid::config,
    content => template('squid/squid.conf.cache_dir.erb'),
    order   => "50-${order}",
  }

  if $manage_dir {
    file{$path:
      ensure  => directory,
      owner   => $squid::daemon_user,
      group   => $squid::daemon_group,
      mode    => '0750',
      require => Package[$squid::package_name],
    }
  }

  if $facts['os']['selinux'] == true {
    selinux::fcontext{"selinux fcontext squid_cache_t ${path}":
      seltype  => 'squid_cache_t',
      pathspec => "${path}(/.*)?",
      require  => File[$path],
      notify   => Selinux::Exec_restorecon["selinux restorecon ${path}"],
    }
    selinux::exec_restorecon{"selinux restorecon ${path}":
      path        => $path,
      refreshonly => true,
    }
  }

}
