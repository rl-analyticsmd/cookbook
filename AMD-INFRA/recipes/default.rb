#
# Cookbook Name:: AMD_INFRA
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#


require 'chef/provisioning/aws_driver'

with_driver 'aws'

aws_vpc node[:AMD_INFRA][:vpc_name] do
  cidr_block node[:AMD_INFRA][:cidr_block]
  main_routes '0.0.0.0/0' => :internet_gateway
  # instance_tenancy :dedicated
  internet_gateway true
end

aws_subnet node[:AMD_INFRA][:aws_pub_subnet] do
  vpc node[:AMD_INFRA][:vpc_name]
  cidr_block node[:AMD_INFRA][:cidr_block_pub]
  # route_table "amd_route"
  availability_zone node[:AMD_INFRA][:availability_zone]
  map_public_ip_on_launch true
end

aws_security_group node[:AMD_INFRA][:security_group] do
  vpc node[:AMD_INFRA][:vpc_name]
  inbound_rules '0.0.0.0/0' => [ 22, 443, 80, 8000, 9418, 3306, 6379 ]
  # inbound_rules '0.0.0.0/0' => [ 22 ]
  outbound_rules [ 80, 443, 22, 8000, 9418, 3306, 6379 ] => '0.0.0.0/0'
end


with_machine_options({
    :source_dest_check => false,
    convergence_options: {
    ssl_verify_mode: :verify_none,
    },
    bootstrap_options: {
    image_id: node[:AMD_INFRA][:amd_image_id], 
    instance_type: node[:AMD_INFRA][:instance_type],
    key_name: node[:AMD_INFRA][:key_name], 
    key_path: node[:AMD_INFRA][:key_path],
    subnet_id: node[:AMD_INFRA][:aws_pub_subnet],
    security_group_ids: node[:AMD_INFRA][:security_group],
    # associate_public_ip_address: false,
    disable_api_termination: true 
      },
    ssh_username: "ec2-user",
    use_private_ip_for_ssh: false, 
    transport_address_location: :public_ip,
})

machine node[:AMD_INFRA][:instance_name] do
  # role node[:AMD_INFRA][:role]
  tag node[:AMD_INFRA][:tag]
  # converge true
  # action :allocate
end 

aws_eip_address node[:AMD_INFRA][:eip] do
  machine node[:AMD_INFRA][:instance_name]
  # associate_to_vpc true
end

machine node[:AMD_INFRA][:instance_name] do
  # role node[:AMD_INFRA][:role]
  tag node[:AMD_INFRA][:tag]
  # converge true
  # action :allocate
end 

aws_route_table node[:AMD_INFRA][:route_table] do
  vpc node[:AMD_INFRA][:vpc_name]
  routes node[:AMD_INFRA][:routes]
  # routes '0.0.0.0/0' => 'yale_test_analytics_nat_instance'
  # aws_tags :chef_type => 'aws_route_table'
end

aws_subnet node[:AMD_INFRA][:aws_pvt_subnet] do
  vpc node[:AMD_INFRA][:vpc_name]
  cidr_block node[:AMD_INFRA][:cidr_block_pvt]
  route_table node[:AMD_INFRA][:route_table]
  availability_zone node[:AMD_INFRA][:availability_zone]
  map_public_ip_on_launch false
end

# include_recipe "AMD_DB_SERVER:default"
