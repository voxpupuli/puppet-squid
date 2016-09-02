class squid::repo
{
  if $::squid::manage_repo {
    case $::osfamily {
      'RedHat': {
        case $::operatingsystemmajrelease {
          '6','7': {
            yumrepo { 'squid':
              name     => 'Squid',
              descr    => 'Squid repo for CentOS Linux - $basearch',
              baseurl  => 'http://www1.ngtech.co.il/repo/centos/$releasever/$basearch/',
              gpgcheck => '1',
            }
          }
          default: {
            # eg Fedora
            fail("Managing a repo on ${::operatingsystem} ${::operatingsystemmajrelease} is currently not implemented")
          }
        }
      }
      default: {
        fail("Managing a repo on ${::osfamily} is currently not implemented")
      }
    }
  }
}
