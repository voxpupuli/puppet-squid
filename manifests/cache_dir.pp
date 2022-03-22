# @summary
#   Defines cache_dir entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/cache_dir/
# @example
#   squid::cache_dir { '/data':
#     type           => 'ufs',
#     options        => '15000 32 256 min-size=32769',
#     process_number => 2,
#   }
#   Results in the squid configuration of
#
#   if ${processor} = 2
#   cache_dir ufs 15000 32 256 min-size=32769
#   endif
#
# @param type
#   The type of cache, e.g ufs. defaults to `ufs`.
# @param path
#   Defaults to the namevar, file path to  cache.
# @param options
#   String of options for the cache.
# @param process_number
#   If specfied as an integer the cache will be wrapped
#   in a `if $proceess_number` statement so the cache will be used by only
#   one process. Default is undef.
# @param manage_dir
#   If true puppet will attempt to create the
#   directory, if false you will have to create it yourself. Make sure the
#   directory has the correct owner, group and mode. Defaults to true.
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
define squid::cache_dir (
  String            $type             = ufs,
  String            $path             = $title,
  Optional[String[1]] $options        = undef,
  Optional[Integer] $process_number   = undef,
  String            $order            = '05',
  Boolean           $manage_dir       = true,
) {
  concat::fragment { "squid_cache_dir_${path}":
    target  => $squid::config,
    content => epp('squid/squid.conf.cache_dir.epp',
      {
        'process_number' => $process_number,
        'path'           => $path,
        'type'           => $type,
        'options'        => $options,
      }
    ),
    order   => "50-${order}",
  }

  if $manage_dir {
    file { $path:
      ensure  => directory,
      owner   => $squid::daemon_user,
      group   => $squid::daemon_group,
      mode    => '0750',
      require => Package[$squid::package_name],
    }
  }

  if fact('os.selinux.enabled') {
    selinux::fcontext { "selinux fcontext squid_cache_t ${path}":
      seltype  => 'squid_cache_t',
      pathspec => "${path}(/.*)?",
      require  => File[$path],
      notify   => Selinux::Exec_restorecon["selinux restorecon ${path}"],
    }
    selinux::exec_restorecon { "selinux restorecon ${path}":
      path        => $path,
      refreshonly => true,
    }
  }
}
