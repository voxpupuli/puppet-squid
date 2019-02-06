# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v2.0.0](https://github.com/voxpupuli/puppet-squid/tree/v2.0.0) (2019-02-06)

[Full Changelog](https://github.com/voxpupuli/puppet-squid/compare/v1.1.0...v2.0.0)

**Breaking changes:**

- modulesync 2.5.1 and drop Puppet4 [\#118](https://github.com/voxpupuli/puppet-squid/pull/118) ([bastelfreak](https://github.com/bastelfreak))
- support listening on specific interfaces; changed params in squid::http\_port{} [\#103](https://github.com/voxpupuli/puppet-squid/pull/103) ([tequeter](https://github.com/tequeter))
- Fix `url\_rewrite\_program` [\#101](https://github.com/voxpupuli/puppet-squid/pull/101) ([SourceDoctor](https://github.com/SourceDoctor))

**Implemented enhancements:**

- Added 'manage\_dir' parameter to cache\_dir [\#116](https://github.com/voxpupuli/puppet-squid/pull/116) ([GeorgeCox](https://github.com/GeorgeCox))
- Add a Squid::Size type [\#112](https://github.com/voxpupuli/puppet-squid/pull/112) ([ekohl](https://github.com/ekohl))
- modulesync 2.2.0 and allow puppet 6.x [\#109](https://github.com/voxpupuli/puppet-squid/pull/109) ([bastelfreak](https://github.com/bastelfreak))
- Allow puppetlabs/stdlib 5.x and puppetlabs/concat 5.x [\#106](https://github.com/voxpupuli/puppet-squid/pull/106) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- ssl::server\_name syntax error [\#117](https://github.com/voxpupuli/puppet-squid/issues/117)
- cache\_dir on mounted filesystem [\#108](https://github.com/voxpupuli/puppet-squid/issues/108)

**Merged pull requests:**

- Use strings not symbols with beaker-puppet `fact\(\)` [\#111](https://github.com/voxpupuli/puppet-squid/pull/111) ([alexjfisher](https://github.com/alexjfisher))
- Update README.md [\#110](https://github.com/voxpupuli/puppet-squid/pull/110) ([AndreasPfaffeneder](https://github.com/AndreasPfaffeneder))
- drop EOL OSs; fix puppet version range [\#100](https://github.com/voxpupuli/puppet-squid/pull/100) ([bastelfreak](https://github.com/bastelfreak))
- use gitrepos in .fixtures.yml [\#99](https://github.com/voxpupuli/puppet-squid/pull/99) ([bastelfreak](https://github.com/bastelfreak))

## [v1.1.0](https://github.com/voxpupuli/puppet-squid/tree/v1.1.0) (2018-05-16)

[Full Changelog](https://github.com/voxpupuli/puppet-squid/compare/v1.0.0...v1.1.0)

**Implemented enhancements:**

- Add `visible\_hostname`, `via`, `httpd\_suppress\_version\_string` and `forwarded\_for` parameters [\#81](https://github.com/voxpupuli/puppet-squid/pull/81) ([SourceDoctor](https://github.com/SourceDoctor))
- add url\_rewrite feature [\#78](https://github.com/voxpupuli/puppet-squid/pull/78) ([SourceDoctor](https://github.com/SourceDoctor))

**Closed issues:**

- puppet/selinux missing as requirement [\#95](https://github.com/voxpupuli/puppet-squid/issues/95)

**Merged pull requests:**

- Fixes \#95 adds declare puppet-selinux dep [\#97](https://github.com/voxpupuli/puppet-squid/pull/97) ([traylenator](https://github.com/traylenator))
- Rely on beaker-hostgenerator for docker nodesets [\#96](https://github.com/voxpupuli/puppet-squid/pull/96) ([ekohl](https://github.com/ekohl))
- increase max concat module version [\#94](https://github.com/voxpupuli/puppet-squid/pull/94) ([TomRitserveldt](https://github.com/TomRitserveldt))

## [v1.0.0](https://github.com/voxpupuli/puppet-squid/tree/v1.0.0) (2018-03-28)

[Full Changelog](https://github.com/voxpupuli/puppet-squid/compare/v0.6.1...v1.0.0)

**Breaking changes:**

- Remove spurious ':' from refresh\_pattern template [\#87](https://github.com/voxpupuli/puppet-squid/pull/87) ([ralfbosz](https://github.com/ralfbosz))

**Implemented enhancements:**

- Syntax check when restarting. [\#76](https://github.com/voxpupuli/puppet-squid/issues/76)
- This commit applies a restorecon when using SELINUX [\#91](https://github.com/voxpupuli/puppet-squid/pull/91) ([ralfbosz](https://github.com/ralfbosz))
- New defined type squid::send\_hit [\#90](https://github.com/voxpupuli/puppet-squid/pull/90) ([traylenator](https://github.com/traylenator))
- Fixes \#8 Set selinux context of cache\_dir and ports.  [\#89](https://github.com/voxpupuli/puppet-squid/pull/89) ([ralfbosz](https://github.com/ralfbosz))
- Allow Cache Replacement Policy to be configured [\#84](https://github.com/voxpupuli/puppet-squid/pull/84) ([SourceDoctor](https://github.com/SourceDoctor))
- Define Stylesheet and language for Squid Errorpage [\#83](https://github.com/voxpupuli/puppet-squid/pull/83) ([SourceDoctor](https://github.com/SourceDoctor))
- enable buffered logs [\#82](https://github.com/voxpupuli/puppet-squid/pull/82) ([SourceDoctor](https://github.com/SourceDoctor))
- add caching store control [\#80](https://github.com/voxpupuli/puppet-squid/pull/80) ([SourceDoctor](https://github.com/SourceDoctor))
- Snmp access [\#79](https://github.com/voxpupuli/puppet-squid/pull/79) ([SourceDoctor](https://github.com/SourceDoctor))

**Closed issues:**

- Support extra\_config\_section to take random configuration [\#31](https://github.com/voxpupuli/puppet-squid/issues/31)
- Set selinux file context on cache directory [\#8](https://github.com/voxpupuli/puppet-squid/issues/8)

**Merged pull requests:**

- Add snmp\_incoming\_address parameter [\#86](https://github.com/voxpupuli/puppet-squid/pull/86) ([alexjfisher](https://github.com/alexjfisher))
- Remove EOL operatingsystems [\#75](https://github.com/voxpupuli/puppet-squid/pull/75) ([ekohl](https://github.com/ekohl))
- Sanitise type [\#73](https://github.com/voxpupuli/puppet-squid/pull/73) ([ekohl](https://github.com/ekohl))
- Run acceptance tests on Debian 9 [\#69](https://github.com/voxpupuli/puppet-squid/pull/69) ([ekohl](https://github.com/ekohl))
- enable all auth\_param types [\#66](https://github.com/voxpupuli/puppet-squid/pull/66) ([quielb](https://github.com/quielb))

## [v0.6.1](https://github.com/voxpupuli/puppet-squid/tree/v0.6.1) (2017-11-15)

[Full Changelog](https://github.com/voxpupuli/puppet-squid/compare/v0.6.0...v0.6.1)

**Merged pull requests:**

- release 0.6.1 [\#72](https://github.com/voxpupuli/puppet-squid/pull/72) ([bastelfreak](https://github.com/bastelfreak))
- add missing secret to travis config [\#71](https://github.com/voxpupuli/puppet-squid/pull/71) ([bastelfreak](https://github.com/bastelfreak))

## [v0.6.0](https://github.com/voxpupuli/puppet-squid/tree/v0.6.0) (2017-11-15)

[Full Changelog](https://github.com/voxpupuli/puppet-squid/compare/v0.5.0...v0.6.0)

**Breaking changes:**

- Convert to puppet 4/5 data types [\#58](https://github.com/voxpupuli/puppet-squid/pull/58) ([matonb](https://github.com/matonb))

**Implemented enhancements:**

- added debian 9 param defaults [\#60](https://github.com/voxpupuli/puppet-squid/pull/60) ([ssanden](https://github.com/ssanden))
- When specifying the extra\_config\_sections as an array [\#45](https://github.com/voxpupuli/puppet-squid/pull/45) ([ralfbosz](https://github.com/ralfbosz))

**Merged pull requests:**

- release 0.6.0 [\#70](https://github.com/voxpupuli/puppet-squid/pull/70) ([bastelfreak](https://github.com/bastelfreak))
- Fix the tests [\#67](https://github.com/voxpupuli/puppet-squid/pull/67) ([ekohl](https://github.com/ekohl))
- Clean up docs [\#62](https://github.com/voxpupuli/puppet-squid/pull/62) ([alexharv074](https://github.com/alexharv074))
- Add refresh\_pattern defined type [\#57](https://github.com/voxpupuli/puppet-squid/pull/57) ([matonb](https://github.com/matonb))
- Use ruby 2.4.1 for beaker tests [\#56](https://github.com/voxpupuli/puppet-squid/pull/56) ([traylenator](https://github.com/traylenator))
- Modulesync 0.21.3 [\#55](https://github.com/voxpupuli/puppet-squid/pull/55) ([traylenator](https://github.com/traylenator))

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


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
