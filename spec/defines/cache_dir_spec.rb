require 'spec_helper'

describe 'squid::cache_dir' do
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
      let(:title) { '/data' }
      context 'when parameters are set' do
        let(:params) do
          {
            type: 'special',
            order: '07',
            process_number: 2,
            options: 'my options for special type'
          }
        end
        it { should contain_concat_fragment('squid_cache_dir_/data').with_target('/tmp/squid.conf') }
        it { should contain_concat_fragment('squid_cache_dir_/data').with_order('50-07') }
        it { should contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^cache_dir special /data my options for special type$}) }
        it { should contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^endif$}) }
        it { should contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^if \${process_number} = 2$}) }
        it { should contain_file('/data').with_ensure('directory') }
        case facts[:operatingsystem]
        when 'Debian'
          it { should contain_file('/data').with_owner('proxy') }
          it { should contain_file('/data').with_group('proxy') }
        when 'Ubuntu'
          case facts[:operatingsystemrelease]
          when '14.04'
            it { should contain_file('/data').with_owner('proxy') }
            it { should contain_file('/data').with_group('proxy') }
          when '16.06'
            it { should contain_file('/data').with_owner('proxy') }
            it { should contain_file('/data').with_group('proxy') }
          end
        else
          it { should contain_file('/data').with_owner('squid') }
          it { should contain_file('/data').with_group('squid') }
        end
      end

      context 'when parameters are set excluding process_number' do
        let(:params) do
          {
            type: 'special',
            order: '07',
            options: 'my options for special type'
          }
        end
        it { should contain_concat_fragment('squid_cache_dir_/data').with_target('/tmp/squid.conf') }
        it { should contain_concat_fragment('squid_cache_dir_/data').with_order('50-07') }
        it { should contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^cache_dir special \/data my options for special type$}) }
        it { should contain_concat_fragment('squid_cache_dir_/data').without_content(%r{^endif$}) }
        it { should contain_concat_fragment('squid_cache_dir_/data').without_content(%r{^if \${process_number}$}) }
      end
    end
  end
end
