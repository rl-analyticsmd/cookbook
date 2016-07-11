#
# Cookbook Name:: AMDAPPDEPLOY_CENTOS7
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

node[:AMDAPPDEPLOY_CENTOS7][:packages].each do |pkg|
	package pkg 
end

package node[:AMDAPPDEPLOY_CENTOS7][:pythonpkg] do
	action :install
end

execute "start mariadb" do
	command "systemctl start mariadb.service"
end

execute "create database" do
	command <<-EOF
	echo "create database analyticsMD" | mysql
	EOF
	# not_if 'echo "create database analyticsMD" | mysql'
end

directory "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD" do
  action :create
end

directory "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/logs" do
  action :create
end

git "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine" do
   repository "https://#{node['AMDAPPDEPLOY_CENTOS7']['git_user']}:#{node['AMDAPPDEPLOY_CENTOS7']['passwd']}@github.com/analyticsMD/medengine.git"
   action :sync
end

template "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/requirements.txt" do
	source 'requirements.txt.erb'
end

execute "install virtual env" do
	command "pip install virtualenv"
end

execute "install setuptools" do
	command "pip install --upgrade setuptools;easy_install -U setuptools"
end

execute "create virtual env" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command "virtualenv devlopment"
end
execute "install group depends" do
	command <<-EOH
	yum groups mark convert
	yum group install -y "Development Tools"
	EOH
end

script "Start Virtual Enviroment" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	user 'root'
  interpreter "bash"
  code <<-EOH
  source "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}"/AMD/medengine/devlopment/bin/activate
  pip install -r requirements.txt
  EOH
end

execute "install ruby expect" do
	command "/opt/chef/embedded/bin/gem install ruby_expect"
end

template "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/amd_deploy.sh" do
	source 'amd_deploy.sh.erb'
	mode '755'
end

execute "create virtual env" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;./amd_deploy.sh"
end

execute "pip install" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;pip install pandas"
end

execute "run resetdb" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;yes yes | python manage.py resetDb"
end

execute "install bower" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;npm install -g bower"
end

execute "install frontend libraries" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/metro/frontend"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;bower install;npm install -g requirejs;npm install -g coffee-script browserify coffeeify less;npm install;yum install coffee-script;cake build"
end

execute "run python script" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;nohup 2>&1 python manage.py runserver 0.0.0.0:8000 &"
end

execute "ideate frontend" do
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/ideate/frontend"
	command "ln -s /usr/bin/nodejs /usr/bin/node;. #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;make"
end
execute "runserver" do 
	cwd "#{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine"
	command ". #{node[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir]}/AMD/medengine/devlopment/bin/activate;nohup 2>&1 python manage.py runserver 0.0.0.0:8000 &"
end
