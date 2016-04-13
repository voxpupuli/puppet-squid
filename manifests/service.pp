class squid::service {

  service{'squid':
    ensure  => true,
    enable  => true,
  }

}
