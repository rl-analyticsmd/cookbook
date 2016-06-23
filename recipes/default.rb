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
  internet_gateway true
end

aws_subnet node[:AMD_INFRA][:aws_pub_subnet] do
  vpc node[:AMD_INFRA][:vpc_name]
  cidr_block '173.0.0.0/24'
  # route_table "amd_route"
  availability_zone node[:AMD_INFRA][:availability_zone]
  map_public_ip_on_launch true
end

aws_security_group node[:AMD_INFRA][:security_group] do
  vpc node[:AMD_INFRA][:vpc_name]
  inbound_rules '0.0.0.0/0' => [ 22, 443, 80 ]
  # inbound_rules '0.0.0.0/0' => [ 22 ]
  outbound_rules [ 80, 443, 22 ] => '0.0.0.0/0'
end


with_machine_options({
	convergence_options: {
    ssl_verify_mode: :verify_none,
    },
    bootstrap_options: {
    image_id: "ami-d482da86", 
    instance_type: node[:AMD_INFRA][:instance_type],
    key_name: node[:AMD_INFRA][:key_name], 
    key_path: node[:AMD_INFRA][:key_path],
    subnet_id: node[:AMD_INFRA][:aws_pub_subnet],
    security_group_ids: node[:AMD_INFRA][:security_group] 
      },
    ssh_username: "ec2-user",
    use_private_ip_for_ssh: false, 
    transport_address_location: :public_ip,
})

machine node[:AMD_INFRA][:instance_name] do
  tag 'ops_analytics'
  # converge true
  # action :ready
end 

aws_route_table node[:AMD_INFRA][:route_table] do
  vpc node[:AMD_INFRA][:vpc_name]
  routes '0.0.0.0/0' => 'analyticsmd_nat_instance'
  # aws_tags :chef_type => 'aws_route_table'
end

aws_subnet node[:AMD_INFRA][:aws_pvt_subnet] do
  vpc node[:AMD_INFRA][:vpc_name]
  cidr_block '173.0.1.0/24'
  route_table node[:AMD_INFRA][:route_table]
  availability_zone node[:AMD_INFRA][:availability_zone]
  map_public_ip_on_launch false
end

# aws_route_table 'amd_route' do
#   vpc 'analyticsmd_vpc'
#   routes {
# main_routes '0.0.0.0/0' => 'analyticsmd_nat_instance'
#   }

#   # aws_tags :chef_type => 'aws_route_table'
# end

