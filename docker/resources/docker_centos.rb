resource_name :docker_centos

action :create do
	execute "#{node['docker']['yum']}"

template '/etc/yum.repos.d/docker.repo' do
  source 'docker.repo.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

execute "docker_centos" do
command "sudo yum -y install docker-engine; sudo service docker start"
not_if 'systemctl status docker | grep running'
end
end