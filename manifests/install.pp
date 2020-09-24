# @summary
#   Installs the squid package
# @api private
class squid::install  {
  package{ $squid::package_name:
    ensure => $squid::package_ensure,
  }

}

