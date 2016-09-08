require 'spec_helper'

describe 'squid::http_port' do
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
      let(:title) { '1000' }
      context 'when parameters are unset' do
        it { should contain_concat_fragment('squid_http_port_1000').with_target('/tmp/squid.conf') }
        it { should contain_concat_fragment('squid_http_port_1000').with_order('30-05') }
        it { should contain_concat_fragment('squid_http_port_1000').with_content(%r{^http_port\s+1000\s*$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            port: 2000,
            options:  'special for 2000',
            order: '08'
          }
        end
        it { should contain_concat_fragment('squid_http_port_2000').with_target('/tmp/squid.conf') }
        it { should contain_concat_fragment('squid_http_port_2000').with_order('30-08') }
        it { should contain_concat_fragment('squid_http_port_2000').with_content(%r{^http_port\s+2000\s+special for 2000$}) }
      end
    end
  end
end
