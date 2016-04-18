require 'spec_helper'
describe 'squid' do
  context 'with defaults for all parameters' do
    it { should contain_class('squid') }
    it { should contain_class('squid::install') }
    it { should contain_class('squid::config') }
    it { should contain_class('squid::service') }
    it { should contain_package('squid').with_ensure('present') }
    it { should contain_service('squid').with_ensure('running') }
    it { should contain_concat('/etc/squid/squid.conf').with_group('squid') }
    it { should contain_concat_fragment('squid_header').with_target('/etc/squid/squid.conf') }
    it { should contain_concat_fragment('squid_header').with_content(/^cache_mem\s+256 MB$/) }
    it { should contain_concat_fragment('squid_header').with_content(/^maximum_object_size_in_memory\s+512 KB$/) }
    it { should contain_concat_fragment('squid_header').with_content(%r{^access_log\s+daemon:/var/logs/squid/access.log\s+squid$}) }
    it { should contain_concat_fragment('squid_header').without_content(/^memory_cache_shared/) }
    it { should contain_concat_fragment('squid_header').without_content(/^coredump_dir/) }
    it { should contain_concat_fragment('squid_header').without_content(/^max_filedescriptors/) }
    it { should contain_concat_fragment('squid_header').without_content(/^workers/) }
  end

  context 'with all parameters set' do
    let :params do
      { config: '/tmp/squid.conf',
        cache_mem: '1024 MB',
        memory_cache_shared: 'on',
        access_log: '/var/log/out.log',
        coredump_dir: '/tmp/core',
        max_filedescriptors: 1000,
        workers: 8,
      }
    end
    it { should contain_concat_fragment('squid_header').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_header').with_content(/^cache_mem\s+1024 MB$/) }
    it { should contain_concat_fragment('squid_header').with_content(/^memory_cache_shared\s+on$/) }
    it { should contain_concat_fragment('squid_header').with_content(%r{^access_log\s+/var/log/out.log$}) }
    it { should contain_concat_fragment('squid_header').with_content(%r{^coredump_dir\s+/tmp/core$}) }
    it { should contain_concat_fragment('squid_header').with_content(/^max_filedescriptors\s+1000$/) }
    it { should contain_concat_fragment('squid_header').with_content(/^workers\s+8$/) }
  end

  context 'with one acl parameter set' do
    let :params do
      { config: '/tmp/squid.conf',
        acls: { 'myacl' => { 'type' => 'urlregex',
                             'order' => '07',
                             'entries' => ['http://example.org/', 'http://example.com/'],
                           },
              },
      }
    end
    it { should contain_concat_fragment('squid_header').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_acl_myacl').with_order('10-07-urlregex') }
    it { should contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.org/$}) }
    it { should contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.com/$}) }
  end

  context 'with two acl parameters set' do
    let :params do
      { config: '/tmp/squid.conf',
        acls: { 'myacl' => { 'type' => 'urlregex',
                             'order' => '07',
                             'entries' => ['http://example.org/', 'http://example.com/'],
                           },
                'mysecondacl' => { 'type' => 'urlregex',
                                   'order' => '08',
                                   'entries' => ['http://example2.org/', 'http://example2.com/'],
                                 },
              },
      }
    end
    it { should contain_concat_fragment('squid_header').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_acl_myacl').with_order('10-07-urlregex') }
    it { should contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.org/$}) }
    it { should contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.com/$}) }
    it { should contain_concat_fragment('squid_acl_mysecondacl').with_order('10-08-urlregex') }
    it { should contain_concat_fragment('squid_acl_mysecondacl').with_content(%r{^acl\s+mysecondacl\s+urlregex\shttp://example2.org/$}) }
    it { should contain_concat_fragment('squid_acl_mysecondacl').with_content(%r{^acl\s+mysecondacl\s+urlregex\shttp://example2.com/$}) }
  end

  context 'with one http_access parameter set' do
    let :params do
      { config: '/tmp/squid.conf',
        http_access: { 'myrule' => { 'action' => 'deny',
                                     'value' => 'this and that',
                                     'order' => '08',
                                   },
                     },
      }
    end
    it { should contain_concat_fragment('squid_header').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_http_access_this and that').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_http_access_this and that').with_order('20-08-deny') }
    it { should contain_concat_fragment('squid_http_access_this and that').with_content(/^http_access\s+deny\s+this and that$/) }
  end

  context 'with two http_access parameters set' do
    let :params do
      { config: '/tmp/squid.conf',
        http_access: { 'myrule' => { 'action' => 'deny',
                                     'value'  => 'this and that',
                                     'order'  => '08',
                                  },
                       'secondrule' => { 'action' => 'deny',
                                         'value'  => 'this too',
                                         'order'  => '09',
                                       },
                     },

      }
    end
    it { should contain_concat_fragment('squid_header').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_http_access_this and that').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_http_access_this and that').with_order('20-08-deny') }
    it { should contain_concat_fragment('squid_http_access_this and that').with_content(/^http_access\s+deny\s+this and that$/) }
    it { should contain_concat_fragment('squid_http_access_this too').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_http_access_this too').with_order('20-09-deny') }
    it { should contain_concat_fragment('squid_http_access_this too').with_content(/^http_access\s+deny\s+this too$/) }
  end
end
