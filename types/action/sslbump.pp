# @summary Possible SSLBump options
#
type Squid::Action::SslBump = Enum[
  'bump',
  'client-first',
  'none',
  'peek',
  'peek-and-splice',
  'server-first',
  'splice',
  'stare',
  'terminate',
]
