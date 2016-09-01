#
# Cookbook Name:: mysqldump_s3
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

execute "mysqldump" do
	cwd "#{node[:mysqldump_s3][:dump_path]}"
	command "mysqldump #{node[:mysqldump_s3][:dbname]} > mysqldump.sql"
end

execute "copymysql dump to s3" do
	cwd "#{node[:mysqldump_s3][:dump_path]}"
	command "s3cmd put - s3://bucket/mysqldump.sql"
end