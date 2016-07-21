require 'chef/provisioning/aws_driver'

with_driver 'aws'

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
    security_group_ids: node[:AMD_DB_SERVER][:sg_ID]
      },
  use_private_ip_for_ssh: false, 
  transport_address_location: :public_ip,
    })

machine node[:AMD_DB_SERVER][:nginx_machine_name] do
	recipe 'AMD_nginx'
  # recipe 'newrelic'
  tag 'amd_nginx'
  converge true
end