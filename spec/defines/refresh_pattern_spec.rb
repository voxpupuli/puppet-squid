require 'spec_helper'

describe 'squid::refresh_pattern' do
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

      context 'when parameters are set' do
        let(:title) { 'my_pattern' }
        let(:params) do
          {
            order:   '06',
            max:     10_080,
            min:     1440,
            percent: 20,
            comment: 'Refresh Patterns'
          }
        end

        fname = 'squid_refresh_pattern_my_pattern'
        it { is_expected.to contain_concat_fragment(fname).with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment(fname).with_order('45-06') }
        it { is_expected.to contain_concat_fragment(fname).with_content(%r{^refresh_pattern\s+my_pattern:\s+1440\s+20%\s+10080$}) }
      end # context 'when parameters are set'

      context 'when parameters are set and case insensitive' do
        let(:title) { 'case_insensitive' }
        let(:params) do
          {
            case_sensitive: false,
            comment:        'Refresh Patterns',
            max:            0,
            min:            0,
            order:          '07',
            percent:        0
          }
        end

        fname = 'squid_refresh_pattern_case_insensitive'
        it { is_expected.to contain_concat_fragment(fname).with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment(fname).with_order('45-07') }
        it { is_expected.to contain_concat_fragment(fname).with_content(%r{^refresh_pattern\s+case_insensitive:\s+-i\s+0\s+0%\s+0$}) }
      end # context 'when parameters are set and case insensitive'
    end
  end
end
