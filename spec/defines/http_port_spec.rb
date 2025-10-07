# frozen_string_literal: true

require 'spec_helper'

describe 'squid::http_port' do
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

      context 'when parameters are unset' do
        let(:title) { '1000' }

        it { is_expected.to contain_concat_fragment('squid_http_port_1000').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_http_port_1000').with_order('30-05') }
        it { is_expected.to contain_concat_fragment('squid_http_port_1000').with_content(%r{^http_port\s+1000$}) }
      end

      context 'with garbage title and no parameters' do
        let(:title) { 'garbage' }

        it { is_expected.not_to compile }
      end

      context 'when host:port title is set' do
        let(:title) { '127.0.0.1:1500' }

        it { is_expected.to contain_concat_fragment('squid_http_port_127.0.0.1:1500').with_content(%r{^http_port\s+127\.0\.0\.1:1500$}) }
      end

      context 'with invalid port (non-numeric) in host:port title' do
        let(:title) { 'my:test' }

        it { is_expected.not_to compile }
      end

      context 'with invalid port (out of range) in host:port title' do
        let(:title) { 'my:100000' }

        it { is_expected.not_to compile }
      end

      context 'with "host: port" invalid title' do
        let(:title) { 'host: 1600' }

        it { is_expected.not_to compile }
      end

      context 'with ".host:port" invalid title' do
        let(:title) { '.host:1600' }

        it { is_expected.not_to compile }
      end

      context 'with host:port title and port arg' do
        let(:title) { 'host:1650' }
        let(:params) do
          {
            port: 1650
          }
        end

        # Ignore the host part of the title if a port is specified
        it { is_expected.to contain_concat_fragment('squid_http_port_host:1650').with_content(%r{^http_port\s+1650$}) }
      end

      context 'with IPv6' do
        let(:title) { 'ipv6_host' }
        let(:params) do
          {
            host: '2001:db8::1',
            port: 1650,
          }
        end

        # Wrap IPv6addresses in square brackets
        it { is_expected.to contain_concat_fragment('squid_http_port_ipv6_host').with_content(%r{^http_port\s+\[2001:db8::1\]:1650$}) }
      end

      context 'without a port specified' do
        let(:title) { 'garbage' }
        let(:params) do
          {
            host: 'host'
          }
        end

        it { is_expected.not_to compile }
      end

      context 'when host and port parameters are set' do
        let(:title) { 'test' }
        let(:params) do
          {
            port: 1700,
            host: '127.0.0.1'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_http_port_test').with_content(%r{^http_port\s+127\.0\.0\.1:1700$}) }
      end

      context 'when parameters are set' do
        let(:title) { 'my:test' } # Arguments shoud override title
        let(:params) do
          {
            port: 2000,
            options: 'special for 2000',
            order: '08'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_http_port_my:test').with_target('/tmp/squid.conf') }
        it { is_expected.to contain_concat_fragment('squid_http_port_my:test').with_order('30-08') }
        it { is_expected.to contain_concat_fragment('squid_http_port_my:test').with_content(%r{^http_port\s+2000\s+special for 2000$}) }
      end

      context 'with host overriding invalid title' do
        let(:title) { 'my:test' }
        let(:params) do
          {
            port: 2100,
            host: 'host'
          }
        end

        it { is_expected.to contain_concat_fragment('squid_http_port_my:test').with_content(%r{^http_port\s+host:2100$}) }
      end

      context 'when ssl => true' do
        let(:title) { '3000' }
        let(:params) do
          {
            ssl: true
          }
        end

        it { is_expected.to contain_concat_fragment('squid_https_port_3000').with_content(%r{^https_port\s+3000$}) }
      end
    end
  end
end
