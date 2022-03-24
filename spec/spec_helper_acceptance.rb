require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  if fact('os.family') == 'RedHat' && fact('os.release.major') != '7'
    on host, puppet('module', 'install', 'puppet-systemd'), acceptable_exit_codes: [0, 1]
  end
end

Dir['./spec/support/acceptance/**/*.rb'].sort.each { |f| require f }
