class squid::install  {

  package{"$::squid::package_name":
    ensure => present,
  }

}

