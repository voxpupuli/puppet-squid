# @summary
#   Defines refresh_pattern entries for a squid server.
# @see http://www.squid-cache.org/Doc/config/refresh_pattern/
# @example
#   squid::refresh_pattern { '^ftp:':
#     min     => 1440,
#     max     => 10080,
#     percent => 20,
#     order   => 60,
#   }
#
#   squid::refresh_pattern { '(/cgi-bin/|\?)':
#     case_sensitive => false,
#     min            => 0,
#     max            => 0,
#     percent        => 0,
#     order          => 61,
#   }
#
#   would result in the following squid refresh patterns:
#   # refresh_pattern fragment for ^ftp
#   refresh_pattern ^ftp: 1440 20% 10080
#   # refresh_pattern fragment for (/cgi-bin/|\?)
#   refresh_pattern (/cgi-bin/|\?) -i 0 0% 0
#
# 
# @example YAML example
#   squid::refresh_patterns:
#     '^ftp':
#       max:     10080
#       min:     1440
#       percent: 20
#       order:   '60'
#     '^gopher':
#       max:     1440
#       min:     1440
#       percent: 0
#       order:   '61'
#     '(/cgi-bin/|\?)':
#       case_sensitive: false
#       max:            0
#       min:            0
#       percent:        0
#       order:          '62'
#     '.':
#       max:     4320
#       min:     0
#       percent: 20
#       order:   '63'
#
# @param case_sensitive 
#   If true (default) the regex is case sensitive, when false the case insensitive flag '-i' is added to the pattern
# @param comment 
#   Comment added before refresh rule, defaults to refresh_pattern fragment for `title`
# @param min 
#   Must be defined, the time (in minutes) an object without an explicit expiry time should be considered fresh.
# @param max 
#   Must be defined, the upper limit (in minutes) on how long objects without an explicit expiry time will be considered fresh.
# @param percent 
#   Must be defined, is a percentage of the objects age (time since last modification age)
# @param options 
#   See squid documentation for available options.
# @param order 
#   Each refresh_pattern has an order `05` by default this can be specified if order of refresh_pattern definition matters.
define squid::refresh_pattern (
  Integer $max,
  Integer $min,
  Integer $percent,
  Boolean $case_sensitive = true,
  String  $options        = '',
  String  $order          = '05',
  String  $pattern        = $title,
  String  $comment        = "refresh_pattern fragment for ${pattern}",
) {
  concat::fragment { "squid_refresh_pattern_${pattern}":
    target  => $squid::config,
    content => template('squid/squid.conf.refresh_pattern.erb'),
    order   => "45-${order}",
  }
}
