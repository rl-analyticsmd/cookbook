require 'chefspec'
describe 'AMDapplication::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

it "should install PACKAGE python" do
	expect(chef_run).to install_package('python')
end

it "check if directory is created" do
['/usr/share/AMD', '/usr/share/AMD/logs'].each do |dir|
expect(chef_run).to create_directory("#{dir}") do
    end
end
end


['/usr/share/AMD/medengine/requirements.txt', '/usr/share/AMD/medengine/config/deployType/prod.py', '/usr/share/AMD/medengine/amd_deploy.sh'].each do |file|
	it "should check if template is created" do
expect(chef_run).to create_template("#{file}") do
  end
end
end

# it "check if directory is created" do
#   expect(chef_run).to create_directory('/AMD')
# end

# it "check if directory is created" do
#   expect(chef_run).to create_directory('/AMD/logs')
# end

# it "should check if template is created" do
#     expect(chef_run).to create_template('/AMD/medengine/requirements.txt')
# end

# it "should check if template is created" do
#     expect(chef_run).to create_template('/AMD/medengine/config/deployType/local.py')
# end

# ('virtualenv', 'setuptools', 'pandas').each do |pkg|
# it "should install package #{pkg}" do
#       expect(chef_run).to install_package pkg
#     end
#   end

#   ('bower', 'phantomjs', 'requirejs','coffeeify').each do |pkg|
# it "should install package #{pkg}" do
#       expect(chef_run).to install_package pkg
#     end
#   end


it "should install virtualenv" do
	expect(chef_run).to run_execute('pip install virtualenv')
end

it "should install setuptools" do
	expect(chef_run).to run_execute('pip install --upgrade setuptools;easy_install -U setuptools')
end

it "should install ruby expect" do
	expect(chef_run).to run_execute('/opt/chef/embedded/bin/gem install ruby_expect')
end

it "should install yum package" do
	expect(chef_run).to run_execute('. /usr/share/AMD/medengine/devlopment/bin/activate;bower install;npm install -g requirejs;npm install -g coffee-script browserify coffeeify less;npm install;yum install coffee-script;cake build')
end

# it "should check if template is created" do
#     expect(chef_run).to create_template('/AMD/medengine/amd_deploy.sh')
# end

it "should install pandas" do
	expect(chef_run).to run_execute('. /usr/share/AMD/medengine/devlopment/bin/activate;pip install pandas')
end

it "should install bower" do
	expect(chef_run).to run_execute('. /usr/share/AMD/medengine/devlopment/bin/activate;npm install -g bower;npm install -g phantomjs')
end

# it "should install phantomjs" do
# 	expect(chef_run).to run_execute('. /usr/share/AMD/medengine/devlopment/bin/activate;npm install -g phantomjs')
# end

# it "should install ruby expect" do
# 	expect(chef_run).to run_execute('npm install -g phantomjs')
# end
end