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
        it { is_expected.to contain_concat_fragment('squid_http_port_1000').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_http_port_1000').with_order('30-05') }
        it { is_expected.to contain_concat_fragment('squid_http_port_1000').with_content(%r{^http_port\s+1000\s*$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            port: 2000,
            options:  'special for 2000',
            order: '08'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_http_port_2000').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_http_port_2000').with_order('30-08') }
        it { is_expected.to contain_concat_fragment('squid_http_port_2000').with_content(%r{^http_port\s+2000\s+special for 2000$}) }
      end
      context 'when ssl => true' do
        let(:title) { '3000' }
        let(:params) do
          {
            ssl: true
          }
        end

        it { is_expected.to contain_concat_fragment('squid_https_port_3000').with_content(%r{^https_port\s+3000\s*$}) }
      end
    end
  end
end
