## [v0.5.0](https://github.com/voxpupuli/puppet-squid/tree/v0.5.0) (2017-03-30)

* Add beaker acceptance tests
* An optional $comment param for http_access and acl (#47)
* Add support for freebsd

## 2017-01-12 - Release 0.4.0

Last release with Puppet 3 support!
* Fix minor syntax issue in README example code
* rubocop: fix RSpec/ImplicitExpect
* adds logformat directive to squid.conf header
* adds test for ::logformat parameter
* Added ssl_bump and sslproxy_cert_error support
* Added support for icp_access Squid conf setting
* Fix ordering issue with missing squid user for cache_dir

## 2016-09-19 - Release 0.3.0
* Add `https_port` defined type.
* Add `extra_config_section` permits extra random configuration.
* The `auth_params` defintions now appear before ACLs as it should.
* New parameters to specify owner of configuration,  daemon name
  and  executer to control cache directory.
* Addition of debian and ubuntu support.

## 2016-06-01 - Release 0.2.2
* Correct documentation examples.

## 2016-06-01 - Release 0.2.1

* All defined types can now be loaded as a hash to *init* and
  so can be loaded easily from hiera.
  e.g
```
class{'squid:
   http_ports => {'10000' =>  { options => 'accel vhost'},
                  '3000'  => {},
                 }
```

## 2016-04-18 - Release 0.1.1

* Add tags to module metadata.

## 2016-04-13 - Release 0.1.0
