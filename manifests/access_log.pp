# @summary
#   Defines access_log entries for a squid server.
# @see
#   http://www.squid-cache.org/Doc/config/access_log/
#
# @example Adds a squid.conf line:
#   squid::access_log: syslog:daemon squid hasRequest
#
#   squid::access_log: { 'myAccessLog' :
#      module    => 'syslog'
#      entries => [
#        'place daemon'
#        'logformat squid'
#        'acl hasRequest'
#     ],
# }
#
# @param module
#   Location of access log
#
# @param entries
#   Access log entry's preceding comment
#
# @param order
#   Order can be used to configure where in `squid.conf`this configuration section should occur.
#
define squid::access_log (
  Enum['none', 'stdio', 'daemon', 'syslog', 'udp', 'tcp'] $module,
  Variant[String[1], Array[String[1]]]                    $entries,
  String[1]                                               $access_log_name = $title,
  String[1]                                               $order           = '50',
) {
  any2array($entries).each |$entry| {
    concat::fragment { "squid_access_log_${access_log_name}_${entry}":
      target  => $squid::config,
      content => epp('squid/squid.conf.access_log.epp', { 'module' => $module, 'entry' => $entry }),
      order   => "38-${order}-${module}",
    }
  }
}
