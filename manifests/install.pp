# Class: squid::install

class squid::install  {

  package{$::squid::package_name:
    ensure => $::squid::package_ensure,
  }

}

