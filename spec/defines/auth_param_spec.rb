require 'spec_helper'

describe 'squid::auth_param' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
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
            entries: entries
          }
        end

        it { is_expected.to contain_concat__fragment('squid_auth_param_auth').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat__fragment('squid_auth_param_auth').with_order('05-07-basic') }
        entries.each do |entry|
          it { is_expected.to contain_concat__fragment('squid_auth_param_auth').with_content(%r{auth_param basic #{entry}}) }
        end
      end
    end
  end
end
