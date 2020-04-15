# Defines [cache_dir entries](http://www.squid-cache.org/Doc/config/cache_dir/) for a squid server.
# squid::cache_dir { '/data':
#   type           => 'ufs',
#   options        => '15000 32 256 min-size=32769',
#   process_number => 2,
# }
# Results in the squid configuration of
#
# if ${processor} = 2
# cache_dir ufs 15000 32 256 min-size=32769
# endif
#
# Parameters for Type squid::cache\_dir
# * type: the type of cache, e.g ufs. defaults to `ufs`.
# * path: defaults to the namevar, file path to  cache.
# * options: String of options for the cache. Defaults to empty string.
# * process_number: if specfied as an integer the cache will be wrapped
#   in a `if $proceess_number` statement so the cache will be used by only
#   one process. Default is undef.
# * manage_dir: Boolean value, if true puppet will attempt to create the
#   directory, if false you will have to create it yourself. Make sure the
#   directory has the correct owner, group and mode. Defaults to true.
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
