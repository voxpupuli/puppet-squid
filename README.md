Puppet module for Squid
=======================

[![Build Status](https://travis-ci.org/voxpupuli/puppet-squid.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-squid)
[![Code Coverage](https://coveralls.io/repos/github/voxpupuli/puppet-squid/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-squid)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/squid.svg)](https://forge.puppetlabs.com/puppet/squid)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/squid.svg)](https://forge.puppetlabs.com/puppet/squid)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/squid.svg)](https://forge.puppetlabs.com/puppet/squid)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/squid.svg)](https://forge.puppetlabs.com/puppet/squid)

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

### Parameters for squid Class
Parameters to the squid class almost map 1 to 1 to squid.conf parameters themselves.

* `ensure_service` The ensure value of the squid service, defaults to `running`.
* `enable_service` The enable value of the squid service, defaults to `true`.
* `config` Location of squid.conf file, defaults to `/etc/squid/squid.conf`.
* `config_user` user which owns the config file, default depends on `$operatingsystem`
* `config_group` group which owns the config file, default depends on `$operatingsystem`
* `daemon_user` user which runs the squid daemon, this is used for ownership of the cache directory, default depends on `$operatingsystem`
* `daemon_group` group which runs the squid daemon, this is used for ownership of the cache directory, default depends on `$operatingsystem`
* `cache_mem` defaults to `256 MB`. [cache_mem docs](http://www.squid-cache.org/Doc/config/cache_mem/).
* `memory_cache_shared` defaults to undef. [memory_cache_shared docs](http://www.squid-cache.org/Doc/config/memory_cache_shared/).
* `maximum_object_size_in_memory` defaults to `512 KB`. [maximum_object_size_in_memory docs](http://www.squid-cache.org/Doc/config/maximum_object_size_in_memory/)
* `access_log` defaults to `daemon:/var/logs/squid/access.log squid`. [access_log docs](http://www.squid-cache.org/Doc/config/access_log/)
* `coredump_dir` defaults to undef. [coredump_dir docs](http://www.squid-cache.org/Doc/config/coredump_dir/).
* `package_name` name of the squid package to manage, default depends on `$operatingsystem`
* `service_name` name of the squid service to manage, default depends on `$operatingsystem`
* `max_filedescriptors` defaults to undef. [max_filedescriptors docs](http://www.squid-cache.org/Doc/config/max_filedescriptors/).
* `workers` defaults to undef. [workers docs](http://www.squid-cache.org/Doc/config/workers/).
* `acls` defaults to undef. If you pass in a hash of acl entries, they will be defined automatically. [acl entries](http://www.squid-cache.org/Doc/config/acl/).
* `http_access` defaults to undef. If you pass in a hash of http_access entries, they will be defined automatically. [http_access entries](http://www.squid-cache.org/Doc/config/http_access/).
* `http_ports` defaults to undef. If you pass in a hash of http_port entries, they will be defined automatically. [http_port entries](http://www.squid-cache.org/Doc/config/http_port/).
* `https_ports` defaults to undef. If you pass in a hash of https_port entries, they will be defined automatically. [https_port entries](http://www.squid-cache.org/Doc/config/https_port/).
* `icp_access` defaults to undef. If you pass in a hash of icp_access entries, they will be defined automatically. [icp_access entries](http://www.squid-cache.org/Doc/config/icp_access/).
* `refresh_patterns` defaults to undef.  If you pass a hash of refresh_pattern entires, they will be defined automatically. [refresh_pattern entries](http://www.squid-cache.org/Doc/config/refresh_pattern/).
* `snmp_ports` defaults to undef. If you pass in a hash of snmp_port entries, they will be defined automatically. [snmp_port entries](http://www.squid-cache.org/Doc/config/snmp_port/).
* `cache_dirs` defaults to undef. If you pass in a hash of cache_dir entries, they will be defined automatically. [cache_dir entries](http://www.squid-cache.org/Doc/config/cache_dir/).
* `ssl_bump` defaults to undef. If you pass in a hash of ssl_bump entries, they will be defined automatically. [ssl_bump entries](http://www.squid-cache.org/Doc/config/ssl_bump/).
* `sslproxy_cert_error` defaults to undef. If you pass in a hash of sslproxy_cert_error entries, they will be defined automatically. [sslproxy_cert_error entries](http://www.squid-cache.org/Doc/config/sslproxy_cert_error/).
* `extra_config_sections` defaults to empty hash. If you pass in a hash of `extra_config_section` resources, they will be defined automatically.

```puppet
class{'::squid':
  cache_mem    => '512 MB',
  workers      => 3,
  coredump_dir => '/var/spool/squid',
}
```

```puppet
class{'::squid':
  cache_mem    => '512 MB',
  workers      => 3,
  coredump_dir => '/var/spool/squid',
  acls         => { 'remote_urls' => {
                       type    => 'url_regex',
                       entries => ['http://example.org/path',
                                   'http://example.com/anotherpath'],
                       },
                  },
  http_access  => { 'our_networks hosts' => { action => 'allow', }},
  http_ports   => { '10000' => { options => 'accel vhost', }},
  snmp_ports   => { '1000' => { process_number => 3, }},
  cache_dirs   => { '/data/' => { type => 'ufs', options => '15000 32 256 min-size=32769', process_number => 2, }},
}
```

The acls, http_access, http_ports, snmp_port, cache_dirs lines above are equivalent to their examples below.

### Defined Type squid::acl
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

These may be defined as a hash passed to ::squid

#### Parameters for  Type squid::acl
* `type` The acltype of the acl, must be defined, e.g url_regex, urlpath_regex, port, ..
* `aclname` The name of acl, defaults to the `title`.
* `entries` An array of acl entries, multiple members results in multiple lines in squid.conf.
* `order` Each ACL has an order `05` by default this can be specified if order of ACL definition matters.


### Defined Type squid::cache\_dir
Defines [cache_dir entries](http://www.squid-cache.org/Doc/config/cache_dir/) for a squid server.

```puppet
squid::cache_dir{'/data':
  type           => 'ufs',
  options        => '15000 32 256 min-size=32769',
  process_number => 2,
}
```

Results in the squid configuration of

```
if ${processor} = 2
cache_dir ufs 15000 32 256 min-size=32769
endif
```

#### Parameters for Type squid::cache\_dir
* `type` the type of cache, e.g ufs. defaults to `ufs`.
* `path` defaults to the namevar, file path to  cache.
* `options` String of options for the cache. Defaults to empty string.
* `process_number` if specfied as an integer the cache will be wrapped
  in a `if $proceess_number` statement so the cache will be used by only
  one process. Default is undef.



### Defined Type squid::http\_access
Defines [http_access entries](http://www.squid-cache.org/Doc/config/http_access/) for a squid server.

```puppet
squid::http_access{'our_networks hosts':
  action => 'allow',
}
```

Adds a squid.conf line 

```
# http_access fragment for out_networks hosts
http_access allow our_networks hosts
```

```puppet
squid::http_access{'our_networks hosts':
  action    => 'allow',
  comment   => 'Our networks hosts are allowed',
}
```

Adds a squid.conf line

```
# Our networks hosts are allowed
http_access allow our_networks hosts
```

These may be defined as a hash passed to ::squid

### Defined Type squid::icp\_access
Defines [icp_access entries](http://www.squid-cache.org/Doc/config/icp_access/) for a squid server.

```puppet
squid::icp_access{'our_networks hosts':
  action => 'allow',
}
```

Adds a squid.conf line 

```
icp_access allow our_networks hosts
```

These may be defined as a hash passed to ::squid

#### Parameters for Type squid::http\_allow
* `value` defaults to the `namevar` the rule to allow or deny.
* `action` must be `deny` or `allow`. By default it is allow. The squid.conf file is ordered so by default
   all allows appear before all denys. This can be overidden with the `order` parameter.
* `order` by default is `05`

### Defined Type Squid::Http\_port
Defines [http_port entries](http://www.squid-cache.org/Doc/config/http_port/) for a squid server.
By setting optional `ssl` parameter to `true` will create [https_port entries](http://www.squid-cache.org/Doc/config/https_port/) instead.

```puppet
squid::http_port{'10000':
  options => 'accel vhost'
}
squid::http_port{'10001':
  ssl     => true,
  options => 'cert=/etc/squid/ssl_cert/server.cert key=/etc/squid/ssl_cert/server.key'
}
```

Results in a squid configuration of

```
http_port 10000 accel vhost
https_port 10001 cert=/etc/squid/ssl_cert/server.cert key=/etc/squid/ssl_cert/server.key
```

#### Parameters for Type squid::http\_port
* `port` defaults to the namevar and is the port number.
* `options` A string to specify any options for the default. By default and empty string.
* `ssl` A boolean.  When set to `true` creates [https_port entries](http://www.squid-cache.org/Doc/config/https_port/).  Defaults to `false`.

### Defined Type Squid::Https\_port
Defines [https_port entries](http://www.squid-cache.org/Doc/config/https_port/) for a squid server.
As an alternative to using the Squid::Http\_port defined type with `ssl` set to `true`, you can use this type instead.  The result is the same. Internally this type uses Squid::Http\_port to create the configuration entries.

#### Parameters for Type squid::https\_port
* `port` defaults to the namevar and is the port number.
* `options` A string to specify any options to add to the https_port line.  Defaults to an empty string.


### Defined Type squid::refresh_pattern
Defines [refresh_pattern entries](http://www.squid-cache.org/Doc/config/refresh_pattern/) for a squid server.

```puppet
squid::refresh_pattern{'^ftp':
   min     => 1440,
   max     => 10080,
   percent => 20,
   order   => 60,
}

squid::refresh_pattern{'(/cgi-bin/|\?)':
   case_sensitive => falke,
   min            => 0,
   max            => 0,
   percent        => 0,
   order          => 61,
}
```

would result in the following squid refresh patterns

```
# refresh_pattern fragment for ^ftp
refresh_pattern ^ftp: 1440 20% 10080
# refresh_pattern fragment for (/cgi-bin/|\?)
refresh_pattern (/cgi-bin/|\?): -i 0 0% 0
```

These may be defined as a hash passed to ::squid

YAML example:
```
squid::refresh_patterns:
  '^ftp':
    max:     10080
    min:     1440
    percent: 20
    order:   '60'
  '^gopher':
    max:     1440
    min:     1440
    percent: 0
    order:   '61'
  '(/cgi-bin/|\?)':
    case_sensitive: false
    max:            0
    min:            0
    percent:        0
    order:          '62'
  '.':
    max:     4320
    min:     0
    percent: 20
    order:   '63'
```

#### Parameters for Type squid::refresh_pattern
* `case_sensitive` Boolean value, if true (default) the regex is case sensitive, when false the case insensitive flag '-i' is added to the pattern
* `comment` Comment added before refresh rule, defaults to refresh_pattern fragment for `title`
* `min` Must be defined, the time (in minutes) an object without an explicit expiry time should be considered fresh.
* `max` Must be defined, the upper limit (in minutes) on how long objects without an explicit expiry time will be considered fresh.
* `percent` Must be defined, is a percentage of the objects age (time since last modification age)
* `options` See squid documentation for available options.
* `order` Each refresh_pattern has an order `05` by default this can be specified if order of refresh_pattern definition matters.


### Defined Type Squid::Snmp\_port
Defines [snmp_port entries](http://www.squid-cache.org/Doc/config/snmp_port/) for a squid server.

```puppet
squid::snmp_port{'1000':
  process_number => 3
}
```

Results in a squid configuration of

```
if ${process_number} = 3
snmp_port 1000
endif
```

#### Parameters for Type squid::http\_port
* `port` defaults to the namevar and is the port number.
* `options` A string to specify any options for the default. By default and empty string.
* `process_number` If set to and integer the snmp\_port is enabled only for
   a particular squid thread. Defaults to undef.

### Defined Type squid::auth\_param
Defines [auth_param entries](http://www.squid-cache.org/Doc/config/auth_param/) for a squid server.

```puppet
squid::auth_param{ 'basic auth_param':
  scheme    => 'basic',
  entries   => ['program /usr/lib64/squid/basic_ncsa_auth /etc/squid/.htpasswd',
                'children 5',
                'realm Squid Basic Authentication',
                'credentialsttl 5 hours'],
}
```

would result in multi entry squid auth_param

```
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/.htpasswd
auth_param basic children 5
auth_param basic realm Squid Basic Authentication
auth_param basic credentialsttl 5 hours
```

These may be defined as a hash passed to ::squid

#### Parameters for  Type squid::auth_param
* `scheme` the scheme used for authentication must be defined
* `entries` An array of entries, multiple members results in multiple lines in squid.conf
* `order` by default is '40'

### Defined Type squid::ssl\_bump
Defines [ssl_bump entries](http://www.squid-cache.org/Doc/config/ssl_bump/) for a squid server.

```puppet
squid::ssl_bump{'all':
  action => 'bump',
}
```

Adds a squid.conf line 

```
ssl_bump bump all
```

These may be defined as a hash passed to ::squid

#### Parameters for Type squid::ssl\_bump
* `value` The type of the ssl_bump, must be defined, e.g bump, peek, ..
* `action` The name of acl, defaults to `bump`.
* `order` by default is `05`

### Defined Type squid::sslproxy\_cert\_error
Defines [sslproxy_cert_error entries](http://www.squid-cache.org/Doc/config/sslproxy_cert_error/) for a squid server.

```puppet
squid::sslproxy_cert_error{'all':
  action => 'allow',
}
```

Adds a squid.conf line 

```
sslproxy_cert_error allow all
```

These may be defined as a hash passed to ::squid

#### Parameters for Type squid::sslproxy\_cert\_error
* `value` defaults to the `namevar` the rule to allow or deny.
* `action` must be `deny` or `allow`. By default it is allow. The squid.conf file is ordered so by default
   all allows appear before all denys. This can be overidden with the `order` parameter.
* `order` by default is `05`

### Defined Type squid::extra\_config\_section
Squid has a large number of configuration directives.  Not all of these have been exposed individually in this module.  For those that haven't, the `extra_config_section` defined type can be used.

```puppet
squid::extra_config_section {'mail settings':
  order          => '60',
  config_entries => {
    'mail_from'    => 'squid@example.com',
    'mail_program' => 'mail',
  },
}
```

Results in a squid configuration of

```
# mail settings
mail_from squid@example.com
mail_program mail
```

And using an array:

```puppet
squid::extra_config_section { 'refresh patterns':
  order          => '60',
  config_entries => [{
    'refresh_pattern' => ['^ftp:           1440    20%     10080',
                          '^gopher:        1440    0%      1440',
                          '-i (/cgi-bin/|\?) 0     0%      0',
                          '.               0       20%     4320'],
  }],
}
```

Results in a squid configuration of

```
# refresh_patterns
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
```

#### Parameters for Type squid::extra\_config\_section
* `comment` defaults to the namevar and is used as a section comment in `squid.conf`.
* `config_entries` A hash of configuration entries to create in this section.  The hash key is the name of the configuration directive.  The value is either a string, or an array of strings to use as the configuration directive options.
* `order` by default is '60'.  It can be used to configure where in `squid.conf` this configuration section should occur.
