#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#
rpm_package 'zabbix' do
  source node[:zabbix_agent][:zabbix_repo]
end


package 'zabbix-agent'

template '/etc/zabbix/zabbix_agentd.conf' do
	source 'zabbix_agentd.conf.erb'
end

execute "disable selinux" do
	command "setenforce 0"
end

service "zabbix-agent" do
supports :status => true, :restart => true, :reload => true
	action :start
end
