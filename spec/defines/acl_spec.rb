require 'spec_helper'

describe 'squid::acl' do
  let :pre_condition  do
    ' class{"::squid":
        config => "/tmp/squid.conf"
      }
    '
  end
  let(:title) { 'myacl' }
  context 'when parameters are set' do
    let(:params) do
      {  type: 'urlregex',
         order: '07',
         entries: ['http://example.org/', 'http://example.com/'],
      }
    end
    it { should contain_concat_fragment('squid_acl_myacl').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_acl_myacl').with_order('10-07-urlregex') }
    it { should contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.org/$}) }
    it { should contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.com/$}) }
  end
end
