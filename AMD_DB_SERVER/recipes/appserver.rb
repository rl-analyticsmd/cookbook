require 'chef/provisioning/aws_driver'

with_driver 'aws'

nat_instance = search(:node, "tags:#{node['AMD_DB_SERVER']['nat_instance_tag']}").first

puts "============================"
puts "#{nat_instance['ec2']['public_ipv4']}"
puts "============================"

with_machine_options({
  convergence_options: {
    ssl_verify_mode: :verify_none,
    },
  bootstrap_options: {
    image_id: node[:AMD_DB_SERVER][:ami_ID], 
    instance_type: node[:AMD_DB_SERVER][:instance_type],
    key_name: node[:AMD_DB_SERVER][:key_name], 
    key_path: node[:AMD_DB_SERVER][:key_path],
    subnet_id: node[:AMD_DB_SERVER][:pvt_subnet_ID],
    security_group_ids: node[:AMD_DB_SERVER][:sg_ID]
    },
  ssh_username: "centos",
  ssh_gateway: "ec2-user@#{nat_instance['ec2']['public_ipv4']}",
  # ssh_gateway: "ec2-user@52.41.28.243",
  use_private_ip_for_ssh: true, 
  transport_address_location: :private_ip
})


machine node[:AMD_DB_SERVER][:app_machine_name] do
  recipe 'AMDapplication'
  # recipe 'newrelic'
  tag node[:AMD_DB_SERVER][:app_tag]
  converge true
  # action :converge_only
end