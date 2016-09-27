require 'chefspec'
describe 'AMD_DB::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

it "includes correct recipe" do
 expect(chef_run).to include_recipe('mount_fsystem')
 end


it "should install PACKAGE mariadb" do
	expect(chef_run).to install_package('mariadb')
end

it "should check if template is created" do
    expect(chef_run).to create_template('/etc/my.cnf')
end

it "check if directory is created" do
  expect(chef_run).to create_directory('/data')
end

it "should check service" do
	expect(chef_run).to run_execute('systemctl start mariadb.service')
end
end

