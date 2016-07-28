require 'chef/provisioning/aws_driver'

with_driver 'aws'

nat_instance = search(:node, 'role:"nat_instance"').first


aws_security_group node[:amd_medengine][:amd_nginx_sg] do
  vpc node[:amd_medengine][:vpc_name]
  inbound_rules "#{nat_instance['ec2']['public_ipv4']}" => [ 22, 443, 80 ]
  # inbound_rules '0.0.0.0/0' => [ 22 ]
  outbound_rules [ 22, 443, 80 ] => '0.0.0.0/0'
end

with_machine_options({
  convergence_options: {
    ssl_verify_mode: :verify_none,
    },
    bootstrap_options: {
    image_id: node[:AMD_DB_SERVER][:nginx_ami_ID], 
    instance_type: node[:AMD_DB_SERVER][:instance_type],
    key_name: node[:AMD_DB_SERVER][:key_name], 
    key_path: node[:AMD_DB_SERVER][:key_path],
    subnet_id: node[:AMD_DB_SERVER][:pub_subnet_ID],
    security_group_ids: node[:AMD_DB_SERVER][:amd_nginx_sg]
      },
  use_private_ip_for_ssh: false, 
  transport_address_location: :public_ip,
    })

machine node[:AMD_DB_SERVER][:nginx_machine_name] do
	recipe 'AMD_nginx'
  recipe 'newrelic_rl'
  tag node[:AMD_DB_SERVER][:nginx_tag]
  converge true
end