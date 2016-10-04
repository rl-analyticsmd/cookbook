require 'chefspec'
describe 'zabbix_agent::default' do
let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

it "should install package zabbix-agent" do
expect(chef_run).to install_package('zabbix-agent')
 end

it "should check if template is created" do
expect(chef_run).to create_template('/etc/zabbix/zabbix_agentd.conf')
  end

it "should check service" do
	expect(chef_run).to start_service('zabbix-agent')
end
end