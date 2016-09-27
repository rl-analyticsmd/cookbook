control 'AMD_DB' do
 describe file('/etc/my.cnf') do
     it { should be_owned_by 'root' }
  end

  describe directory('/data') do
     it { should be_owned_by 'mysql' }
  end

  describe service('mariadb') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
    it { should be_listening }
  end
end


