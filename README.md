Squid module for Puppet
========================

[![Puppet Forge](http://img.shields.io/puppetforge/v/puppet/squid.svg)](https://forge.puppetlabs.com/puppet/squid)
[![Build Status](https://travis-ci.org/voxpupuli/puppet-squid.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-squid)


Description
-----------

Puppet module for configuring the squid caching service.

Usage
-----

The set up a simple squid server with a cache to forward
http port 80 requests.

```puppet
class{'::squid':}
squid::acl{'Safe_ports':
  type    => port,
  entries => ['80'],
}
squid::http_access{'Safe_ports':
  action => allow,
}
squid::http_access{'!Safe_ports':
  action => deny,
}
```

### Parameters for Squid Class
Parameters to the squid class almost map 1 to 1 to squid.conf parameters themselves.

* `config` Location of squid.conf file, defaults to `/etc/squid/squid.conf`.
* `cache_mem` defaults to `256 MB`. [cache_mem docs](http://www.squid-cache.org/Doc/config/cache_mem/).
* `memory_cache_shared` defaults to undef. [memory_cache_shared docs](http://www.squid-cache.org/Doc/config/memory_cache_shared/).
* `maximum_object_size_in_memory` defaults to `512 KB`. [maximum_object_size_in_memory docs](http://www.squid-cache.org/Doc/config/maximum_object_size_in_memory/)
* `access_log` defaults to `daemon:/var/logs/squid/access.log squid`. [access_log docs](http://www.squid-cache.org/Doc/config/access_log/)
* `coredump_dir` defaults to undef. [coredump_dir docs](http://www.squid-cache.org/Doc/config/coredump_dir/).
* `max_filedescriptors` defaults to undef. [max_filedescriptors docs](http://www.squid-cache.org/Doc/config/max_filedescriptors/).
* `workers` defaults to undef. [workers docs](http://www.squid-cache.org/Doc/config/workers/).

```puppet
class{'::squid':
  cache_mem    = '512 MB',
  workers      = 3,
  coredump_dir = '/var/spool/squid',
}
```

### Defined Type Squid::Acl
Defines [acl entries](http://www.squid-cache.org/Doc/config/acl/) for a squid server.

```puppet
squid::acl{'remote_urls':
   type    => 'url_regex',
   entries => ['http://example.org/path',
               'http://example.com/anotherpath'],

}
```

would result in a multi entry squid acl

```
acl remote_urls url_regex http://example.org/path
acl remote_urls url_regex http://example.com/anotherpath
```

#### Parameters for  Type Squid::Acl
* `type` The acltype of the acl, must be defined, e.g url_regex, urlpath_regex, port, ..
* `aclname` The name of acl, defaults to the `title`.
* `entries` An array of acl entres, multple members results in multiple lines in squid.conf.
* `order` Each ACL has an order `05` by default this can be specified if order of ACL definition matters.


### Defined Type Squid::Cache\_dir
TBD

### Defined Type Squid::Http\_access
TDB

### Defined Type Squid::Http\_port
TBD

### Defined Type Squid::Snmp\_port
TBD





