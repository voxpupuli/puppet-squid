require 'spec_helper'

describe 'squid::cache_dir' do
  let :pre_condition  do
   ' class{"::squid": 
       config => "/tmp/squid.conf"
     }
   '
  end
  let(:title) {'/data'}
  context "when parameters are set" do 
    let(:params) do 
      {  :type     => 'special',
         :order    => '07',
         :process_number => 2,
         :options  => 'my options for special type'
      }
    end
    it { should contain_concat_fragment('squid_cache_dir_/data').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_cache_dir_/data').with_order('50-07') }
    it { should contain_concat_fragment('squid_cache_dir_/data').with_content(/^cache_dir special \/data my options for special type$/) }
    it { should contain_concat_fragment('squid_cache_dir_/data').with_content(/^endif$/) }
    it { should contain_concat_fragment('squid_cache_dir_/data').with_content(/^if \${process_number} = 2$/) }
    it { should contain_file('/data').with_ensure('directory') }
  end

  context "when parameters are set excluding process_number" do 
    let(:params) do 
      {  :type     => 'special',
         :order    => '07',
         :options  => 'my options for special type'
      }
    end
    it { should contain_concat_fragment('squid_cache_dir_/data').with_target('/tmp/squid.conf') }
    it { should contain_concat_fragment('squid_cache_dir_/data').with_order('50-07') }
    it { should contain_concat_fragment('squid_cache_dir_/data').with_content(/^cache_dir special \/data my options for special type$/) }
    it { should contain_concat_fragment('squid_cache_dir_/data').without_content(/^endif$/) }
    it { should contain_concat_fragment('squid_cache_dir_/data').without_content(/^if \${process_number}$/) }
  end
end
