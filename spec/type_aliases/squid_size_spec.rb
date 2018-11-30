require 'spec_helper'

describe 'Squid::Size' do
  it { is_expected.to allow_value('1 KB') }
  it { is_expected.to allow_value('1 MB') }
  it { is_expected.to allow_value('10 KB') }
  it { is_expected.to allow_value('9876543210 KB') }
  it { is_expected.not_to allow_value('-1 KB') }
  it { is_expected.not_to allow_value('1 kB') }
  it { is_expected.not_to allow_value('1 Kb') }
  it { is_expected.not_to allow_value('1 Mb') }
  it { is_expected.not_to allow_value('1 KBB') }
  it { is_expected.not_to allow_value('a KBB') }
  it { is_expected.not_to allow_value('1KB') }
end
