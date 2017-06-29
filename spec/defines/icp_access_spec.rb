require 'spec_helper'

describe 'squid::icp_access' do
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
      let(:title) { 'myrule' }

      context 'when parameters are unset' do
        it { is_expected.to contain_concat_fragment('squid_icp_access_myrule').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_icp_access_myrule').with_order('30-05-allow') }
        it { is_expected.to contain_concat_fragment('squid_icp_access_myrule').with_content(%r{^icp_access\s+allow\s+myrule$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            action: 'deny',
            value: 'this and that',
            order: '08'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_icp_access_this and that').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_icp_access_this and that').with_order('30-08-deny') }
        it { is_expected.to contain_concat_fragment('squid_icp_access_this and that').with_content(%r{^icp_access\s+deny\s+this and that$}) }
      end

      context 'with unknown action' do
        let(:params) do
          {
            action: 'unknown_action'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{parameter 'action' expects a match}) }
      end
    end
  end
end
