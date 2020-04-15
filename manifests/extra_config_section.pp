# Defined Type squid::extra\_config\_section
# Squid has a large number of configuration directives.  Not all of these have been exposed individually in this module.  
# For those that haven't, the `extra_config_section` defined type can be used.
# 
# Using a hash of config_entries:
# 
# squid::extra_config_section { 'mail settings':
#   order          => '60',
#   config_entries => {
#     'mail_from'    => 'squid@example.com',
#     'mail_program' => 'mail',
#   },
# }
# 
# Results in a squid configuration of
# 
# # mail settings
# mail_from squid@example.com
# mail_program mail
# 
# Using an array of config_entries:
# 
# squid::extra_config_section { 'ssl_bump settings':
#   order          => '60',
#   config_entries => {
#     'ssl_bump'         => ['server-first', 'all'],
#     'sslcrtd_program'  => ['/usr/lib64/squid/ssl_crtd', '-s', '/var/lib/ssl_db', '-M', '4MB'],
#     'sslcrtd_children' => ['8', 'startup=1', 'idle=1'],
#   }
# }
# 
# Results in a squid configuration of
# 
# # ssl_bump settings
# ssl_bump server-first all
# sslcrtd_program /usr/lib64/squid/ssl_crtd -s /var/lib/ssl_db -M 4MB
# sslcrtd_children 8 startup=1 idle=1
# 
# Using an array of hashes of config_entries:
# 
# squid::extra_config_section { 'always_directs':
#   order          => '60',
#   config_entries => [{
#     'always_direct' => ['deny    www.reallyreallybadplace.com',
#                         'allow   my-good-dst',
#                         'allow   my-other-good-dst'],
#   }],
# }
# 
# Results in a squid configuration of
# 
# # always_directs
# always_direct deny    www.reallyreallybadplace.com
# always_direct allow   my-good-dst
# always_direct allow   my-other-good-dst
# 
# Parameters for Type squid::extra\_config\_section
# comment: defaults to the namevar and is used as a section comment in `squid.conf`.
# config_entries: A hash of configuration entries to create in this section.  The hash key is the name of the configuration directive.  
# The value is either a string, or an array of strings to use as the configuration directive options.
# order: by default is '60'.  It can be used to configure where in `squid.conf` this configuration section should occur.
define squid::extra_config_section (
  String              $comment = $title,
  Variant[Array,Hash] $config_entries = {},
  String              $order   = '60',
) {

  concat::fragment{"squid_extra_config_section_${comment}":
    target  => $squid::config,
    content => template('squid/squid.conf.extra_config_section.erb'),
    order   => "${order}-${comment}",
  }
}
