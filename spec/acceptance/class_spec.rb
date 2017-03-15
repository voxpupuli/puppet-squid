require 'spec_helper_acceptance'

describe 'squid class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'squid':}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package("squid#{fact(:operatingsystem) == 'Debian' && fact(:operatingsystemmajrelease) == '8' ? '3' : ''}") do
      it { is_expected.to be_installed }
    end
    describe service("squid#{fact(:operatingsystem) == 'Debian' && fact(:operatingsystemmajrelease) == '8' ? '3' : ''}") do
      it { is_expected.to be_running }
    end
  end

  context 'configure http_access' do
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
    describe file("/etc/squid#{fact(:operatingsystem) == 'Debian' && fact(:operatingsystemmajrelease) == '8' ? '3' : ''}/squid.conf") do
      it { is_expected.to be_file }
      it { is_expected.to contain(%r{^http_access allow our_networks\s*$}) }
      it { is_expected.to contain(%r{^http_port 3128\s*$}) }
      it { is_expected.to contain(%r{^acl our_networks src all\s*$}) }
    end
  end
end
