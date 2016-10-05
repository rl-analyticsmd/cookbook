require 'chefspec'
describe 'AMD_nginx::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

it "should install PACKAGE nginx" do
	expect(chef_run).to run_execute('apt-get install nginx -y')
end

it 'creates a cookbook_file' do
      expect(chef_run).to create_cookbook_file('/etc/nginx/wildcard.crt')
end

it 'creates a cookbook_file' do
      expect(chef_run).to create_cookbook_file('/etc/nginx/wildcard.key')
end

it "should check service" do
	expect(chef_run).to restart_service('nginx')
end
end