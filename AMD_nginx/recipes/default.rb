#
# Cookbook Name:: AMD_nginx
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#


execute 'update' do 
	command "apt-get update -y"
end

execute "nginx install" do
	command "apt-get install nginx -y"
	#action :install
end


cookbook_file '/etc/nginx/wildcard.crt' do
  source 'wildcard.crt'
  action :create
end


cookbook_file '/etc/nginx/wildcard.key' do
  source 'wildcard.key'
  action :create
end

# appserver = search(:node, "tags:#{node['AMD_nginx']['tag']}")

# puts appserver.class

# template "/etc/nginx/sites-enabled/amdapp.conf" do
# 	source 'amdapp.conf.erb'
# 	variables(
# 		:appserver => appserver
# 		)
# 	# notifies :reload, 'service[nginx]', :immediately
# end

 execute 'move file' do
	cwd '/etc/nginx/sites-enabled'
	command "mv default /tmp"
	only_if 'ls default', :cwd => '/etc/nginx/sites-enabled'
end

service 'nginx' do 
	supports :restart => true, :stop => true, :start => true, :reload => true
	#action :restart
  	 action [:enable, :start]
end