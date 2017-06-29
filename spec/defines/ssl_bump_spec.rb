require 'spec_helper'

describe 'squid::ssl_bump' do
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
        it { is_expected.to contain_concat_fragment('squid_ssl_bump_bump_myrule').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_ssl_bump_bump_myrule').with_order('25-05-bump') }
        it { is_expected.to contain_concat_fragment('squid_ssl_bump_bump_myrule').with_content(%r{^ssl_bump\s+bump\s+myrule$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            action: 'peek',
            value: 'step1',
            order: '08'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_ssl_bump_peek_step1').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_ssl_bump_peek_step1').with_order('25-08-peek') }
        it { is_expected.to contain_concat_fragment('squid_ssl_bump_peek_step1').with_content(%r{^ssl_bump\s+peek\s+step1$}) }
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
