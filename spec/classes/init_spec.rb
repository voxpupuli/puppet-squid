require 'spec_helper'
describe 'squid' do

  context 'with defaults for all parameters' do
    it { should contain_class('squid') }
  end
end
