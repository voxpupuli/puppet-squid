class squid::service inherits squid {

  service{'squid':
    ensure => $squid::ensure_service,
    enable => $squid::enable_service,
  }

}
