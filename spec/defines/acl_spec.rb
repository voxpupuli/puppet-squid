require 'spec_helper'

describe 'squid::acl' do
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
      let(:title) { 'myacl' }

      context 'when parameters are set' do
        let(:params) do
          {
            type: 'urlregex',
            order: '07',
            entries: ['http://example.org/', 'http://example.com/'],
            comment: 'Example company website'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_acl_myacl').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_acl_myacl').with_order('10-07-urlregex') }
        it { is_expected.to contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.org/$}) }
        it { is_expected.to contain_concat_fragment('squid_acl_myacl').with_content(%r{^acl\s+myacl\s+urlregex\shttp://example.com/$}) }
        it { is_expected.to contain_concat_fragment('squid_acl_myacl').with_content(%r{^# Example company website$}) }
      end
    end
  end
end
