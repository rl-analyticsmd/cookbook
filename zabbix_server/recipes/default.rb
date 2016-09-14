#
# Cookbook Name:: zabbix-server
# Recipe:: default
#
# Copyright 2016, AnalyticsMD
#
# All rights reserved - Do Not Redistribute
#
rpm_package 'zabbix' do
  source node[:zabbix_server][:zabbix_repo]
end


package 'zabbix-server'

template '/etc/zabbix/zabbix_agentd.conf' do
	source 'zabbix_agentd.conf.erb'
end

execute "disable selinux" do
	command "setenforce 0"
end

service "zabbix-server" do
supports :status => true, :restart => true, :reload => true
	action :start
end
