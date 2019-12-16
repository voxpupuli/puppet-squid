type Squid::PkgEnsure = Variant[
  Pattern[/^\d.*/],
  Enum['present', 'latest', 'absent', 'purged', 'held', 'installed'],
]
