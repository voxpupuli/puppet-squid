require 'spec_helper'

describe 'squid::https_port' do
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
      let(:title) { '4000' }
      let(:params) do
        {
          options: 'some options'
        }
      end

      it 'uses `squid::http_port` with `ssl` set to true' do
        is_expected.to contain_squid__http_port('4000').with_ssl(true)
      end
      it 'passes options to `squid::http_port`' do
        is_expected.to contain_squid__http_port('4000').with_options('some options')
      end
      it 'results in the correct concat fragment being created' do
        is_expected.to contain_concat_fragment('squid_https_port_4000').with_content(%r{^https_port\s+4000\ssome options\s*$})
      end
    end
  end
end
