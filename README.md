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
class { 'squid': }
squid::acl { 'Safe_ports':
  type    => port,
  entries => ['80'],
}
squid::http_access { 'Safe_ports':
  action => allow,
}
squid::http_access{ '!Safe_ports':
  action => deny,
}
```
This module will set the SELINUX-context for the cache_dir and/or port, requires [puppet-selinux](https://github.com/voxpupuli/puppet-selinux)

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
* `cache_replacement_policy` defaults to undef. [cache_replacement_policy docs](http://www.squid-cache.org/Doc/config/cache_replacement_policy/).
* `memory_replacement_policy` defaults to undef. [memory_replacement_policy docs](http://www.squid-cache.org/Doc/config/memory_replacement_policy/).
* `memory_cache_shared` defaults to undef. [memory_cache_shared docs](http://www.squid-cache.org/Doc/config/memory_cache_shared/).
* `maximum_object_size_in_memory` defaults to `512 KB`. [maximum_object_size_in_memory docs](http://www.squid-cache.org/Doc/config/maximum_object_size_in_memory/)

* `url_rewrite_program` defaults to undef [url_rewrite_program_docs](http://www.squid-cache.org/Doc/config/url_rewrite_program/)
* `url_rewrite_children` defaults to undef [url_rewrite_children_docs](http://www.squid-cache.org/Doc/config/url_rewrite_children/)
* `url_rewrite_child_options` defaults to undef [url_rewrite_child_options_docs](http://www.squid-cache.org/Doc/config/url_rewrite_children/)
* `access_log` defaults to `daemon:/var/logs/squid/access.log squid`. [access_log docs](http://www.squid-cache.org/Doc/config/access_log/)
* `coredump_dir` defaults to undef. [coredump_dir docs](http://www.squid-cache.org/Doc/config/coredump_dir/).
* `error_directory` defaults to undef. [error_directory](http://www.squid-cache.org/Doc/config/error_directory/).
* `err_page_stylesheet` defaults to undef. [err_page_stylesheet](http://www.squid-cache.org/Doc/config/err_page_stylesheet/).
* `package_name` name of the squid package to manage, default depends on `$operatingsystem`
* `package_ensure` package status and/or version, default to present
* `service_name` name of the squid service to manage, default depends on `$operatingsystem`
* `max_filedescriptors` defaults to undef. [max_filedescriptors docs](http://www.squid-cache.org/Doc/config/max_filedescriptors/).
* `workers` defaults to undef. [workers docs](http://www.squid-cache.org/Doc/config/workers/).
* `snmp_incoming_address` defaults to undef. Can be set to an IP address to only listen for snmp requests on an individual interface. [snmp_incoming_address](http://www.squid-cache.org/Doc/config/snmp_incoming_address/).
* `buffered_logs` defaults to undef. [buffered_logs docs](http://www.squid-cache.org/Doc/config/buffered_logs/).
* `acls` defaults to undef. If you pass in a hash of acl entries, they will be defined automatically. [acl entries](http://www.squid-cache.org/Doc/config/acl/).
* `visible_hostname` defaults to undef. [visible_hostname docs](http://www.squid-cache.org/Doc/config/visible_hostname/)
* `via` defaults to undef. [via docs](http://www.squid-cache.org/Doc/config/via/)
* `httpd_suppress_version_string` defaults to undef. [httpd_suppress_version_string docs](http://www.squid-cache.org/Doc/config/httpd_suppress_version_string/)
* `forwarded_for` defaults to undef. supported values are "on", "off", "transparent", "delete", "truncate". [forwarded_for docs](http://www.squid-cache.org/Doc/config/forwarded_for/)
* `http_access` defaults to undef. If you pass in a hash of http_access entries, they will be defined automatically. [http_access entries](http://www.squid-cache.org/Doc/config/http_access/).
* `http_ports` defaults to undef. If you pass in a hash of http_port entries, they will be defined automatically. [http_port entries](http://www.squid-cache.org/Doc/config/http_port/).
* `https_ports` defaults to undef. If you pass in a hash of https_port entries, they will be defined automatically. [https_port entries](http://www.squid-cache.org/Doc/config/https_port/).
* `icp_access` defaults to undef. If you pass in a hash of icp_access entries, they will be defined automatically. [icp_access entries](http://www.squid-cache.org/Doc/config/icp_access/).
* `logformat` defaults to undef. If you pass in a String (or Array of Strings), they will be defined automatically. [logformat entries](http://www.squid-cache.org/Doc/config/logformat/).
* `refresh_patterns` defaults to undef.  If you pass a hash of refresh_pattern entires, they will be defined automatically. [refresh_pattern entries](http://www.squid-cache.org/Doc/config/refresh_pattern/).
* `snmp_ports` defaults to undef. If you pass in a hash of snmp_port entries, they will be defined automatically. [snmp_port entries](http://www.squid-cache.org/Doc/config/snmp_port/).
* `send_hit` defaults to undef. If you pass in a hash of send_hit entries, they will be defined automatically. [send_hit entries](http://www.squid-cache.org/Doc/config/send_hit/).
* `cache_dirs` defaults to undef. If you pass in a hash of cache_dir entries, they will be defined automatically. [cache_dir entries](http://www.squid-cache.org/Doc/config/cache_dir/).
* `ssl_bump` defaults to undef. If you pass in a hash of ssl_bump entries, they will be defined automatically. [ssl_bump entries](http://www.squid-cache.org/Doc/config/ssl_bump/).
* `sslproxy_cert_error` defaults to undef. If you pass in a hash of sslproxy_cert_error entries, they will be defined automatically. [sslproxy_cert_error entries](http://www.squid-cache.org/Doc/config/sslproxy_cert_error/).
* `extra_config_sections` defaults to empty hash. If you pass in a hash of `extra_config_section` resources, they will be defined automatically.
* `service_restart` defaults to undef. Overrides service resource restart command to be executed. It can be used to perform a soft reload of the squid service.
* `squid_bin_path` path to the squid binary, default depends on `$operatingsystem`

```puppet
class { 'squid':
  cache_mem    => '512 MB',
  workers      => 3,
  coredump_dir => '/var/spool/squid',
}
```

```puppet
class { 'squid':
  cache_mem                 => '512 MB',
  workers                   => 3,
  coredump_dir              => '/var/spool/squid',
  acls                      => { 'remote_urls' => {
                                   type    => 'url_regex',
                                   entries => ['http://example.org/path',
                                               'http://example.com/anotherpath'],
                                 },
                               },
  http_access               => { 'our_networks hosts' => { action => 'allow', }},
  http_ports                => { '10000' => { options => 'accel vhost', }},
  snmp_ports                => { '1000' => { process_number => 3, }},
  cache_dirs                => { '/data/' => { type => 'ufs', options => '15000 32 256 min-size=32769', process_number => 2 }},
  url_rewrite_program       => '/usr/bin/squidguard -c /etc/squidguard/squidguard.conf',
  url_rewrite_children      => 12,
  url_rewrite_child_options => startup=1,
}
```

The acls, http_access, http_ports, snmp_port, cache_dirs lines above are equivalent to their examples below.

### Defined Type squid::acl
Defines [acl entries](http://www.squid-cache.org/Doc/config/acl/) for a squid server.

```puppet
squid::acl { 'remote_urls':
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
squid::cache_dir { '/data':
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
* `manage_dir` Boolean value, if true puppet will attempt to create the
  directory, if false you will have to create it yourself. Make sure the
  directory has the correct owner, group and mode. Defaults to true.

### Defined Type squid::cache
Defines [cache entries](http://www.squid-cache.org/Doc/config/cache/) for a squid server.

```puppet
squid::cache { 'our_network_hosts_acl':
  action    => 'deny',
  comment   => 'Our networks hosts are denied for caching',
}
```

Adds a squid.conf line

```
# Our networks hosts denied for caching
cache deny our_network_hosts_acl
```

### Defined Type squid::http\_access
Defines [http_access entries](http://www.squid-cache.org/Doc/config/http_access/) for a squid server.

```puppet
squid::http_access { 'our_networks hosts':
  action => 'allow',
}
```

Adds a squid.conf line

```
# http_access fragment for out_networks hosts
http_access allow our_networks hosts
```

```puppet
squid::http_access { 'our_networks hosts':
  action    => 'allow',
  comment   => 'Our networks hosts are allowed',
}
```

Adds a squid.conf line

```
# Our networks hosts are allowed
http_access allow our_networks hosts
```

### Define Type squid::send\_hit
Defines [send_hit](http://www.squid-cache.org/Doc/config/send_hit/) for a squid server.

```puppet
squid:::send_hit{'PragmaNoCache':
  action => 'deny',
}
```

Adds a squid.conf line

```
send_hit deny PragmaNoCache
```

#### Parameters for Type squid::send\hit
`value` defaults to the `namevar`. The rule to allow or deny.
`action` must one of `deny` or `allow`
`order` by default is 05.
`comment` A comment to add to the configuration file.

### Defined Type squid::snmp\_access
Defines [snmp_access entries](http://www.squid-cache.org/Doc/config/snmp_access/) for a squid server.

```puppet
squid::snmp_access { 'monitoring hosts':
  action => 'allow',
}
```

Adds a squid.conf line

```
# snmp_access fragment for monitoring hosts
snmp_access allow monitoring hosts
```

```puppet
squid::snmp_access { 'monitoring hosts':
  action    => 'allow',
  comment   => 'Our monitoring hosts are allowed',
}
```

Adds a squid.conf line

```
# Our monitoring hosts are allowed
snmp_access allow monitoring hosts
```

These may be defined as a hash passed to ::squid

### Defined Type squid::icp\_access
Defines [icp_access entries](http://www.squid-cache.org/Doc/config/icp_access/) for a squid server.

```puppet
squid::icp_access { 'our_networks hosts':
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
squid::http_port { '10000':
  options => 'accel vhost'
}
squid::http_port { '10001':
  ssl     => true,
  options => 'cert=/etc/squid/ssl_cert/server.cert key=/etc/squid/ssl_cert/server.key'
}
squid::http_port { '127.0.0.1:3128':
}
```

Results in a squid configuration of

```
http_port 10000 accel vhost
https_port 10001 cert=/etc/squid/ssl_cert/server.cert key=/etc/squid/ssl_cert/server.key
http_port 127.0.0.1:3128
```

#### Parameters for Type squid::http\_port
* The title/namevar may be in the form `port` or `host:port` to provide the below values. Otherwise,
  specify `port` explicitly, and `host` if desired.
* `port` defaults to the port of the namevar and is the port number to listen on.
* `host` defaults to the host part of the namevar and is the interface to listen on. If not specified,
  Squid listens on all interfaces.
* `options` A string to specify any options for the default. By default and empty string.
* `ssl` A boolean.  When set to `true` creates [https_port entries](http://www.squid-cache.org/Doc/config/https_port/).  Defaults to `false`.

### Defined Type Squid::Https\_port
Defines [https_port entries](http://www.squid-cache.org/Doc/config/https_port/) for a squid server.
As an alternative to using the Squid::Http\_port defined type with `ssl` set to `true`, you can use this type instead.  The result is the same. Internally this type uses Squid::Http\_port to create the configuration entries.

#### Parameters for Type squid::https\_port
* `port` defaults to the namevar and is the port number.
* `options` A string to specify any options to add to the https_port line.  Defaults to an empty string.

### Defined Type squid::url_rewrite_program
Defines [url_rewrite_program](http://www.squid-cache.org/Doc/config/url_rewrite_program/) for a squid server.

```puppet
squid::url_rewrite_program { '/usr/bin/squidGuard -c /etc/squidguard/squidGuard.conf':
  children      => 8,
  child_options => 'startup=0 idle=1 concurrency=0',
}
```

would result in the following squid url rewrite program

```
url_rewrite_program /usr/bin/squidGuard -c /etc/squidguard/squidGuard.conf
url_rewrite_children 8 startup=0 idle=1 concurrency=0
```

### Defined Type squid::refresh_pattern
Defines [refresh_pattern entries](http://www.squid-cache.org/Doc/config/refresh_pattern/) for a squid server.

```puppet
squid::refresh_pattern { '^ftp:':
  min     => 1440,
  max     => 10080,
  percent => 20,
  order   => 60,
}

squid::refresh_pattern { '(/cgi-bin/|\?)':
  case_sensitive => false,
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
refresh_pattern (/cgi-bin/|\?) -i 0 0% 0
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
squid::snmp_port { '1000':
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
squid::auth_param { 'basic auth_param':
  scheme  => 'basic',
  entries => [
    'program /usr/lib64/squid/basic_ncsa_auth /etc/squid/.htpasswd',
    'children 5',
    'realm Squid Basic Authentication',
    'credentialsttl 5 hours',
  ],
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
squid::ssl_bump { 'all':
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
squid::sslproxy_cert_error { 'all':
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

Using a hash of config_entries:

```puppet
squid::extra_config_section { 'mail settings':
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

Using an array of config_entries:

```puppet
squid::extra_config_section { 'ssl_bump settings':
  order          => '60',
  config_entries => {
    'ssl_bump'         => ['server-first', 'all'],
    'sslcrtd_program'  => ['/usr/lib64/squid/ssl_crtd', '-s', '/var/lib/ssl_db', '-M', '4MB'],
    'sslcrtd_children' => ['8', 'startup=1', 'idle=1'],
  }
}
```

Results in a squid configuration of

```
# ssl_bump settings
ssl_bump server-first all
sslcrtd_program /usr/lib64/squid/ssl_crtd -s /var/lib/ssl_db -M 4MB
sslcrtd_children 8 startup=1 idle=1
```

Using an array of hashes of config_entries:

```puppet
squid::extra_config_section { 'always_directs':
  order          => '60',
  config_entries => [{
    'always_direct' => ['deny    www.reallyreallybadplace.com',
                        'allow   my-good-dst',
                        'allow   my-other-good-dst'],
  }],
}
```

Results in a squid configuration of

```
# always_directs
always_direct deny    www.reallyreallybadplace.com
always_direct allow   my-good-dst
always_direct allow   my-other-good-dst
```

#### Parameters for Type squid::extra\_config\_section
* `comment` defaults to the namevar and is used as a section comment in `squid.conf`.
* `config_entries` A hash of configuration entries to create in this section.  The hash key is the name of the configuration directive.  The value is either a string, or an array of strings to use as the configuration directive options.
* `order` by default is '60'.  It can be used to configure where in `squid.conf` this configuration section should occur.
