require 'chef/provisioning/aws_driver'

with_driver 'aws'

nat_instance = search(:node, 'role:"nat_instance"').first


aws_security_group node[:amd_medengine][:amd_db_sg] do
  vpc node[:amd_medengine][:vpc_name]
  inbound_rules "#{nat_instance['ec2']['public_ipv4']}" => [ 22, 443, 80, 3306 ]
  # inbound_rules '0.0.0.0/0' => [ 22 ]
  outbound_rules [ 22, 443, 80, 3306 ] => '0.0.0.0/0'
end


with_machine_options({
  convergence_options: {
    ssl_verify_mode: :verify_none,
    },
    bootstrap_options: {
    image_id: node[:amd_medengine][:db_ami_ID], 
    instance_type: node[:amd_medengine][:instance_type],
    key_name: node[:amd_medengine][:key_name], 
    key_path: node[:amd_medengine][:key_path],
    subnet_id: node[:amd_medengine][:pvt_subnet_ID],
    security_group_ids: node[:amd_medengine][:amd_db_sg]
      },
  ssh_username: "centos",
  ssh_gateway: "ec2-user@#{nat_instance['ec2']['public_ipv4']}",   
  use_private_ip_for_ssh: false, 
  transport_address_location: :private_ip,
    })

machine node[:amd_medengine][:db_machine_name] do
  tag node[:amd_medengine][:db_tag]
end

aws_ebs_volume node[:amd_medengine][:ebs_volume] do
  machine node[:amd_medengine][:db_machine_name]
  availability_zone 'a'
  size 20
  iops 600
  volume_type 'io1'
  encrypted true
  device '/dev/sda2'
  aws_tags :chef_type => 'aws_ebs_volume'
end

machine node[:amd_medengine][:db_machine_name] do
  recipe 'AMD_DB'
  recipe 'newrelic_rl'
  tag node[:amd_medengine][:db_tag]
  converge true
end