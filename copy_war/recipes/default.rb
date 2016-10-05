#
# Cookbook Name:: copy_war
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#
package 'git' do 
	action :install
	not_if 'ps -ef | grep git'
end


git "#{Chef::Config[:file_cache_path]}/sample" do
   repository "https://github.com/cphany/sample.git"
   action :sync
end
execute "copy war file" do
	cwd "#{Chef::Config[:file_cache_path]}/sample/AntExample1/AntExample1/dist/"
	command "cp AntExample.war /var/lib/tomcat7/webapps"
end
service 'tomcat7' do
supports :restart => true
action :restart
end