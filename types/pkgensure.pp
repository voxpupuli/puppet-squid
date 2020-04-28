# @summary
#   Custom type representing package status and/or version
type Squid::PkgEnsure = Variant[
  Pattern[/^\d.*/],
  Enum['present', 'latest', 'absent', 'purged', 'held', 'installed'],
]
