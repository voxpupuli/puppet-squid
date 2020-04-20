# @summary
#   Installs the squid package
class squid::install  {

  package{$squid::package_name:
    ensure => $squid::package_ensure,
  }

}

