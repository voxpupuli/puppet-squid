require 'spec_helper'

describe 'squid::snmp_listen_ip', type: :class do
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
      let(:params) do
        {
          listen_ip: '127.0.0.1'
        }
      end

      context 'with minimal parameters' do
        it { is_expected.to contain_concat_fragment('squid_snmp_listen_ip_127.0.0.1').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_snmp_listen_ip_127.0.0.1').with_order('40-05') }
        it { is_expected.to contain_concat_fragment('squid_snmp_listen_ip_127.0.0.1').with_content(%r{^snmp_incoming_address\s+127.0.0.1\s*$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            listen_ip: '1.2.3.4',
            options: 'special for 1.2.3.4',
            order: '08'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_snmp_listen_ip_1.2.3.4').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_snmp_listen_ip_1.2.3.4').with_order('40-08') }
        it { is_expected.to contain_concat_fragment('squid_snmp_listen_ip_1.2.3.4').with_content(%r{^snmp_incoming_address\s+1.2.3.4\s+special for 1.2.3.4\s*$}) }
      end
    end
  end
end
