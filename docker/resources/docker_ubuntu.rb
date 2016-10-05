resource_name :docker_ubuntu


action :create do
execute "apt-get" do
  command "#{node['docker']['apt']}; sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D"
  action :run
end

template '/etc/apt/sources.list.d/docker.list' do
  source 'docker.list.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

execute "docker-ubuntu" do
  command "#{node['docker']['apt']}; #{node['docker']['skipinter']} purge lxc-docker; apt-cache policy docker-engine; #{node['docker']['apt']}; #{node['docker']['skipinter']} install linux-image-extra-$(uname -r); #{node['docker']['skipinter']} install apparmor; #{node['docker']['apt']}; #{node['docker']['skipinter']} install linux-image-generic-lts-trusty; #{node['docker']['apt']}; #{node['docker']['skipinter']} install docker-engine"
  action :run
  not_if 'service docker status | grep running'
end 
end