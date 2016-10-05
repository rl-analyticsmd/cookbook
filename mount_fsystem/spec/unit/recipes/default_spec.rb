require 'chefspec'
describe ' mount_fsystem::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

it 'creates a directory with attributes' do
    expect(chef_run).to create_directory('/mnt/mysql').with(
      user: 'mysql',
      group: 'mysql',
      mode: '0775'
    )

 it 'enable  a mount with attributes' do
 expect(chef_run).to enable_mount('/var/lib/mysql')
end


 it "should install PACKAGE nginx" do
	expect(chef_run).to run_execute(' mv #{node['mount_fsystem']['data_dir']} #{node['mount_fsystem']['mount_point']}')
	not_if do
		FileTest.directory?(node['mount_fsystem']['mount_point']) 
	end
end

