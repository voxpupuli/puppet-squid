require 'spec_helper'

describe 'squid::snmp_port' do
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
        it { is_expected.to contain_concat_fragment('squid_snmp_port_1000').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_1000').with_order('40-05') }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_1000').with_content(%r{^snmp_port\s+1000\s*$}) }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_1000').without_content(%r{^endif$}) }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_1000').without_content(%r{^if \${process_number}$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            port: 2000,
            options: 'special for 2000',
            order: '08',
            process_number: 3
          }
        end

        it { is_expected.to contain_concat_fragment('squid_snmp_port_2000').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_2000').with_order('40-08') }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_2000').with_content(%r{^snmp_port\s+2000\s+special for 2000$}) }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_2000').with_content(%r{^if \${process_number} = 3$}) }
        it { is_expected.to contain_concat_fragment('squid_snmp_port_2000').with_content(%r{^endif$}) }
      end
    end
  end
end
