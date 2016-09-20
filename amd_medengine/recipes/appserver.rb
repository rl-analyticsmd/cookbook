require 'chef/provisioning/aws_driver'

with_driver 'aws'

nat_instance = search(:node, 'role:"nat_instance"').first
db_server = search(:node, 'tags:"demo-db"').first

puts "============================"
puts "#{nat_instance['ec2']['public_ipv4']}"
puts "============================"


aws_security_group node[:amd_medengine][:amd_app_sg] do
  vpc node[:amd_medengine][:vpc_name]
  inbound_rules "#{nat_instance['ec2']['public_ipv4']}" => [ 22, 443, 80, 8000, 9418 ],
                 "#{db_server['ipaddress']}" => [ 3306 ]
  # inbound_rules '0.0.0.0/0' => [ 22 ]
  outbound_rules [ 22, 443, 80, 8000, 9418 ] => '0.0.0.0/0'
end


with_machine_options({
  convergence_options: {
    ssl_verify_mode: :verify_none,
    },
  bootstrap_options: {
    image_id: node[:amd_medengine][:ami_ID], 
    instance_type: node[:amd_medengine][:instance_type],
    key_name: node[:amd_medengine][:key_name], 
    key_path: node[:amd_medengine][:key_path],
    subnet_id: node[:amd_medengine][:pvt_subnet_ID],
    dedicated_tenancy: true,
    security_group_ids: node[:amd_medengine][:amd_app_sg]
    },
  ssh_username: "centos",
  ssh_gateway: "ec2-user@#{nat_instance['ec2']['public_ipv4']}",
  # ssh_gateway: "ec2-user@52.41.28.243",
  use_private_ip_for_ssh: true, 
  transport_address_location: :private_ip
})


machine node[:amd_medengine][:app_machine_name] do
  recipe 'AMDapplication'
  recipe 'newrelic_rl'
  tag node[:amd_medengine][:app_tag]
  converge true
  # action :converge_only
end