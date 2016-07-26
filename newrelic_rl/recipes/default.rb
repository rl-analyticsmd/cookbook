#
# Cookbook Name:: newrelic_rl
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# search for data bag and get the keys
# what is being stored in data bag 
	# 
# assign it to default attribute
# include_recipe "newrelic"
# 

newrelic_dbg_data = data_bag_item(node[:newrelic][:data_bag], node[:newrelic][:data_bag_item])

node.default['newrelic']['license'] = newrelic_dbg_data["license"]
node.default['newrelic']['application_monitoring']['license'] = newrelic_dbg_data["app_monitor_license"]
node.default['newrelic']['api_key'] = newrelic_dbg_data["api_key"]
app_stack = newrelic_dbg_data["app_stack"]

include_recipe "newrelic::default"

# begin
	include_recipe "newrelic::#{app_stack}_agent"
# rescue Chef::Exception::RecipeNotFound
# 	puts "Application stack would be from 'dotnet','java','nodejs','php','python','ruby'"
# end
