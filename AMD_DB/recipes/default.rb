#
# Cookbook Name:: AMD_DB
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
	#

node[:AMD_DB][:db_package].each do |pkg|
package pkg
end

#include_recipe "mount_fsystem::default"

template node[:AMD_DB][:mysql_dir] do
	source 'my.cnf.erb'
end

directory '/data' do
owner 'mysql'
 action :create
end

execute "change owner" do
	command "chown -R mysql:mysql /data"
end 

execute "enable selinux" do
	command "setenforce 0"
end

execute "start mariadb" do
	command "systemctl start mariadb.service"
end

# # db_server = search(:node, 'tags:"demo_db1"').first

execute "create database" do
	command <<-EOF
	echo "create database analyticsMD" | mysql
	echo "grant all on analyticsMD.* to 'root'@'%' identified by 'root';" | mysql
	echo "flush privileges;" | mysql
	EOF
	 #not_if 'mysql -uroot -e "show databases" | grep analyticsMD'
end

# template '/etc/hostname' do
# 	source 'hostname.erb'
# end

