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

#template '/etc/zabbix/zabbix_agentd.conf' do
#	source 'zabbix_agentd.conf.erb'
#end

# execute "disable selinux" do
# 	command "setenforce 0"
# end

# Per Ian, he said don't disable selinux.  But we need to remove any zabbix module, if it were there before.
execute "remove any preexisting zabbix module from selinx" do
	command "semodule -r zabbix"
end

execute "install mysql for zabbix server" do
	yum install zabbix-server-mysql zabbix-web-mysql
end

# Now, configure the mysql db.
execute "configure mysql db for zabbix server" do
	cd /usr/share/doc/zabbix-server-mysql-3.0.0
	zcat create.sql.gz | mysql -uroot zabbix
end

# Now, setup the zabbix server config file
template '/etc/zabbix/zabbix_server.conf' do
       source 'zabbix_server.conf.erb'
end

# Now, configure zabbix frontend
template '/etc/httpd/conf.d/zabbix.conf' do
	source 'zabbix_httpd.conf.erb'
end


service "zabbix-server" do
supports :status => true, :restart => true, :reload => true
	action :start
end
