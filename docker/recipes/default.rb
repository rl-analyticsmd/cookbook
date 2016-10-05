#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



case node['platform_family']
 when 'debian'

    docker_ubuntu 'ubuntu' do
	action :create
end

when 'rhel', 'fedora'

	docker_centos 'centos' do
		action :create
end

end


  



