# frozen_string_literal: true

require 'spec_helper'

describe 'squid::access_log' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let :pre_condition do
        ' class{"squid":
            config => "/tmp/squid.conf"
          }
        '
      end
      let(:title) { 'myaccess_log' }

      context 'when parameters are set' do
        let(:params) do
          {
            module: 'syslog',
            entries: %w[foo bar],
            order: '57',
          }
        end

        it {
          is_expected.to contain_concat_fragment('squid_access_log_myaccess_log_foo').with(
            {
              'target'  => '/tmp/squid.conf',
              'content' => %r{^access_log syslog:foo$},
              'order'   => '38-57-syslog',
            }
          )
        }

        it {
          is_expected.to contain_concat_fragment('squid_access_log_myaccess_log_bar').with(
            {
              'target'  => '/tmp/squid.conf',
              'content' => %r{^access_log syslog:bar$},
              'order'   => '38-57-syslog',
            }
          )
        }
      end
    end
  end
end
