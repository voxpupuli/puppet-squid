require 'spec_helper'

describe 'squid::url_rewrite_program' do
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
      let(:title) { 'someprogram' }

      context 'when parameters are unset' do
        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someprogram').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someprogram').with_order('44-05') }
        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someprogram').with_content(%r{^url_rewrite_program\s+someprogram\s*$}) }
      end
      context 'when parameters are set' do
        let(:params) do
          {
            program: 'someotherprogram',
            children: 10,
            order: '08'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someotherprogram').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someotherprogram').with_order('44-08') }
        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someotherprogram').with_content(%r{^url_rewrite_program\s+someotherprogram\s*$}) }
        it { is_expected.to contain_concat_fragment('squid_url_rewrite_program_someotherprogram').with_content(%r{^url_rewrite_children\s+10\s*$}) }
      end
    end
  end
end
