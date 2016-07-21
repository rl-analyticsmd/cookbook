require 'chef/provisioning/aws_driver'

with_driver 'aws'

nat_instance = search(:node, 'role:"nat_instance"').first

with_machine_options({
  convergence_options: {
    ssl_verify_mode: :verify_none,
    },
    bootstrap_options: {
    image_id: node[:AMD_DB_SERVER][:db_ami_ID], 
    instance_type: node[:AMD_DB_SERVER][:instance_type],
    key_name: node[:AMD_DB_SERVER][:key_name], 
    key_path: node[:AMD_DB_SERVER][:key_path],
    subnet_id: node[:AMD_DB_SERVER][:pvt_subnet_ID],
    security_group_ids: node[:AMD_DB_SERVER][:sg_ID]
      },
  ssh_username: "centos",
  ssh_gateway: "ec2-user@#{nat_instance['ec2']['public_ipv4']}",   
  use_private_ip_for_ssh: false, 
  transport_address_location: :private_ip,
    })

machine node[:AMD_DB_SERVER][:db_machine_name] do
  tag node[:AMD_DB_SERVER][:tag]
end

aws_ebs_volume 'amd_ebs_voltest1' do
  machine node[:AMD_DB_SERVER][:db_machine_name]
  availability_zone 'c'
  size 20
  iops 600
  volume_type 'io1'
  encrypted true
  device '/dev/sda2'
  aws_tags :chef_type => 'aws_ebs_volume'
end

machine node[:AMD_DB_SERVER][:db_machine_name] do
  recipe 'AMD_DB'
  recipe 'newrelic'
  tag node[:AMD_DB_SERVER][:tag]
  converge true
end