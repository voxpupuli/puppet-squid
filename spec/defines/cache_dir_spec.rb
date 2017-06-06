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

        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_order('50-07') }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^cache_dir special /data my options for special type$}) }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^endif$}) }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^if \${process_number} = 2$}) }
        it { is_expected.to contain_file('/data').with_ensure('directory') }
        case facts[:operatingsystem]
        when 'Debian'
          context 'when on Debian' do
            it { is_expected.to contain_file('/data').with_owner('proxy') }
            it { is_expected.to contain_file('/data').with_group('proxy') }
          end
        when 'Ubuntu'
          case facts[:operatingsystemrelease]
          when '14.04'
            context 'when on Ubuntu 14.04' do
              it { is_expected.to contain_file('/data').with_owner('proxy') }
              it { is_expected.to contain_file('/data').with_group('proxy') }
            end
          when '16.04'
            context 'when on Ubuntu 16.04' do
              it { is_expected.to contain_file('/data').with_owner('proxy') }
              it { is_expected.to contain_file('/data').with_group('proxy') }
            end
          end
        else
          context 'when on any other non-debian OS' do
            it { is_expected.to contain_file('/data').with_owner('squid') }
            it { is_expected.to contain_file('/data').with_group('squid') }
          end
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

        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_order('50-07') }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').with_content(%r{^cache_dir special \/data my options for special type$}) }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').without_content(%r{^endif$}) }
        it { is_expected.to contain_concat_fragment('squid_cache_dir_/data').without_content(%r{^if \${process_number}$}) }
      end
    end
  end
end
