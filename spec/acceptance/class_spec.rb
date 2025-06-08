# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'squid class' do
  context 'configure http_access with default service type' do
    it 'works idempotently with no errors' do
      pp = <<~EOS
        class { 'squid':}
        squid::http_port{'3128':}
        squid::acl{'our_networks':
          type    => src,
          entries => ['all'],
        }
        squid::http_access{'our_networks':
          action    => 'allow',
          comment   => 'Our networks hosts are allowed',
        }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'configure http_access with simple service type' do
    it 'works idempotently with no errors' do
      pp = <<-EOS
        class { 'squid':}
        squid::http_port{'3128':}
        squid::acl{'our_networks':
          type    => src,
          entries => ['all'],
        }
        squid::http_access{'our_networks':
          action    => 'allow',
          comment   => 'Our networks hosts are allowed',
        }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('squid') do
      it { is_expected.to be_installed }
    end

    describe service('squid') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe file('/etc/squid/squid.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain(%r{^http_access allow our_networks\s*$}) }
      it { is_expected.to contain(%r{^http_port 3128\s*$}) }
      it { is_expected.to contain(%r{^acl our_networks src all\s*$}) }
    end
  end
end
