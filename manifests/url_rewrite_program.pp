class squid::url_rewrite_program (
  String $program                 = $title,
  String $order                   = '05',
  Optional[Integer] $children     = undef,
  Optional[String] $child_options = undef,

) {

  concat::fragment{'squid_url_rewrite_program':
    target  => $squid::config,
    content => template('squid/squid.conf.url_rewrite_program.erb'),
    order   => "44-${order}",
  }

}
