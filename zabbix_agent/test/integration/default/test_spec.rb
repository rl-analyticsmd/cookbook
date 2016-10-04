control 'zabbix_agent' do

describe package('zabbix-agent') do
  it { should be_installed }
end

describe file('/etc/zabbix/zabbix_agentd.conf') do
     it { should exist }
end

describe service('zabbix-agent') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
end