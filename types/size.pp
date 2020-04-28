# @summary
#  Custom type containing the numeral value and the unit of messurement (Kilo- or Megabyte)
type Squid::Size = Pattern[/^\d+ [KM]B$/]
