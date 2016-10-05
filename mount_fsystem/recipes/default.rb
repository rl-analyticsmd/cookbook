#
# Cookbook Name:: mount_fsystem
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

bash 'format disk' do
  code <<-EOH
echo "n
p
1


w
"|fdisk "#{node[:mount_fsystem][:disk_name]}";mkfs."#{node[:mount_fsystem][:fs_type]}" "#{node[:mount_fsystem][:device_name]}" 
    EOH
end

directory node[:mount_fsystem][:mount_point] do
  owner node[:mount_fsystem][:dir_owner]
  group node[:mount_fsystem][:dir_group]
  mode node[:mount_fsystem][:dir_mode]
  action :create
end
	
mount 'mount filesystem' do
  device node[:mount_fsystem][:device_name]
  mount_point node[:mount_fsystem][:mount_point]
  fstype node[:mount_fsystem][:fs_type]
  options 'rw'
  action [:mount, :enable]
end

execute 'install-mysql' do
    command "mv #{node['mount_fsystem']['data_dir']} #{node['mount_fsystem']['mount_point']}"
    not_if do FileTest.directory?(node['mount_fsystem']['mount_point']) end
end