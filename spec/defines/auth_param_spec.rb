require 'spec_helper'

describe 'squid::auth_param' do
  let :pre_condition do
    ' class{"::squid":
        config => "/tmp/squid.conf"
      }
    '
  end
  let(:title) { 'auth' }
  context 'when parameters are set' do
    entries = ['program /usr/lib64/squid/basic_ncsa_auth /etc/squid/.htpasswd',
               'children 5',
               'realm Squid Basic Authentication',
               'credentialsttl 5 hours']

    let(:params) do
      {
        scheme: 'basic',
        order: '07',
        entries: entries,
      }
    end
    it { should contain_concat__fragment('squid_auth_param_auth').with_target('/tmp/squid.conf') }
    it { should contain_concat__fragment('squid_auth_param_auth').with_order('40-07-basic') }
    entries.each do |entry|
      it { should contain_concat__fragment('squid_auth_param_auth').with_content(/auth_param basic #{entry}/) }
    end
  end
end
