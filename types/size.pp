# @summary
#  Custom type containing the numeral value and the unit of messurement (Kilo-, Mega-, or Gigabyte)
type Squid::Size = Pattern[/^\d+ [KMG]B$/]
