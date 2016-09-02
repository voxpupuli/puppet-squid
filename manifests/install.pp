class squid::install  {
  ensure_packages($::squid::package_name)
}
