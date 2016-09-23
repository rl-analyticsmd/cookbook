#
# Cookbook Name:: AMDapplication
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

node[:AMDapplication][:packages].each do |pkg|
	package pkg 
end

package node[:AMDapplication][:pythonpkg] do
	action :install
end

directory "#{node[:AMDapplication][:amdapp_dir]}/AMD" do
  action :create
end

directory "#{node[:AMDapplication][:amdapp_dir]}/AMD/logs" do
  action :create
end

git "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine" do
   repository "https://#{node['AMDapplication']['git_user']}:#{node['AMDapplication']['passwd']}@github.com/analyticsMD/medengine.git"
   action :sync
end

template "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/requirements.txt" do
	source 'requirements.txt.erb'
end

execute 'start redis' do
	command "service redis start"
end

dbserver = search(:node, "tags:#{node['AMDapplication']['dbserver_tag']}").first

puts "============================"
puts "#{dbserver['ipaddress']}"
puts "============================"


template "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/config/deployType/prod.py" do
	source 'prod.py.erb'
	variables(
		:dbserver => "#{dbserver['ipaddress']}"
		)
end

# template "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/settings.py" do
# 	source 'settings.py.erb'
# 	variables(
# 		:dbserver => dbserver
# 		)
# end

execute "install virtual env" do
	command "pip install virtualenv"
end

execute "install setuptools" do
	command "pip install --upgrade setuptools;easy_install -U setuptools"
end

execute "create virtual env" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command "virtualenv devlopment"
end
execute "install group depends" do
	command <<-EOH
	yum groups mark convert
	yum group install -y "Development Tools"
	EOH
end

script "Start Virtual Enviroment" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	user 'root'
  interpreter "bash"
  code <<-EOH
  source "#{node[:AMDapplication][:amdapp_dir]}"/AMD/medengine/devlopment/bin/activate
  pip install -r requirements.txt
  EOH
end

execute "install ruby expect" do
	command "/opt/chef/embedded/bin/gem install ruby_expect"
end

template "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/amd_deploy.sh" do
	source 'amd_deploy.sh.erb'
	mode '755'
end

# template "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/config/deploy.config.json" do
# 	source 'deploy.config.json.erb'
# end


execute "create virtual env" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;./amd_deploy.sh"
end

execute "pip install" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;pip install pandas"
end

execute "run resetdb" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;yes yes | python manage.py resetDb"
	# not_if "mysql -h  -e 'select * from main_metric' analyticsMD"
end

execute "install bower" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;npm install -g bower;npm install -g phantomjs"
end

execute "install frontend libraries" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/metro/frontend"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;bower install;npm install -g requirejs;npm install -g coffee-script browserify coffeeify less;npm install;yum install coffee-script;cake build"
end

execute "run python script" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;nohup 2>&1 python manage.py runserver 0.0.0.0:8000 &"
end

execute "ideate frontend" do
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/ideate/frontend"
	command "ln -s /usr/bin/nodejs /usr/bin/node;. #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;make"
end

execute "runserver" do 
	cwd "#{node[:AMDapplication][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDapplication][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;nohup 2>&1 python manage.py runserver 0.0.0.0:8000 &"
end
