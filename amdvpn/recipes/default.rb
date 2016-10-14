#
# Cookbook Name:: amd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# execute 'command' do 
# 	command "sudo yum install openswan lsof"
# end

package node[:amdvpn][:packages] do
	action :install
end

# directory '/proc/sys/net/ipv4/conf/eth0' do
#  action :create
# end

# template '/tmp/script.sh' do
#   source 'script.sh.erb'
#   mode 0755
#   action :create
# end

execute 'command' do
# cwd '/tmp' 
command <<-EOF
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/default/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/lo/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/default/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/eth0/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/lo/accept_redirects
EOF
end

template '/etc/sysctl.conf' do
  source 'sysctl.conf.erb'
end


execute 'command' do
cwd '/etc' 
command "sysctl -p"
end

# directory '/etc/ipsec.d' do
# action :create
#  end


directory "#{node[:amdvpn][:amdvpn_dir]}/ipsec.d" do
  action :create
end

template '/etc/ipsec.d/someHospital.conf' do
  source 'someHospital.conf.erb'
end

# template "#{node[:amdvpn][:amdvpn_dir]}/ipsec.d/someHospital.conf" do
# 	source 'someHospital.conf.erb'
# end


cookbook_file '/etc/ipsec.secrets' do
  source 'ipsec.secrets'
  action :create
end

service 'ipsec' do
supports :restart => true
  action [ :enable, :start ]
end

execute 'command' do 
	command "iptables -I INPUT -s 11.111.11.111 -j ACCEPT"
end