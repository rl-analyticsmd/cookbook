#
# Cookbook Name:: amd_infra_new
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#


require 'chef/provisioning/aws_driver'

with_driver 'aws'

aws_vpc node[:amd_infra_new][:vpc_name] do
  cidr_block node[:amd_infra_new][:cidr_block]
  main_routes '0.0.0.0/0' => :internet_gateway
  internet_gateway true
end

aws_subnet node[:amd_infra_new][:aws_pub_subnet] do
  vpc node[:amd_infra_new][:vpc_name]
  cidr_block '173.0.0.0/24'
  # route_table "amd_route"
  availability_zone node[:amd_infra_new][:availability_zone]
  map_public_ip_on_launch true
end

aws_security_group node[:amd_infra_new][:security_group] do
  vpc node[:amd_infra_new][:vpc_name]
  inbound_rules '0.0.0.0/0' => [ 22, 443, 80, 8000, 9418, 3306 ]
  # inbound_rules '0.0.0.0/0' => [ 22 ]
  outbound_rules [ 80, 443, 22, 8000, 9418, 3306 ] => '0.0.0.0/0'
end


with_machine_options({
    :source_dest_check => false,
    convergence_options: {
    ssl_verify_mode: :verify_none,
    },
    bootstrap_options: {
    image_id: node[:amd_infra_new][:amd_image_id], 
    instance_type: node[:amd_infra_new][:instance_type],
    key_name: node[:amd_infra_new][:key_name], 
    key_path: node[:amd_infra_new][:key_path],
    subnet_id: node[:amd_infra_new][:aws_pub_subnet],
    # dedicated_tenancy: true,
    security_group_ids: node[:amd_infra_new][:security_group] 
      },
    ssh_username: "ec2-user",
    use_private_ip_for_ssh: false, 
    transport_address_location: :public_ip,
})

machine node[:amd_infra_new][:instance_name] do
  role 'nat_instance'
  tag 'nat_instancetest'
  converge true
  # action :ready
end 

aws_route_table node[:amd_infra_new][:route_table] do
  vpc node[:amd_infra_new][:vpc_name]
  routes '0.0.0.0/0' => 'analytics_nat_instance'
  # aws_tags :chef_type => 'aws_route_table'
end

aws_subnet node[:amd_infra_new][:aws_pvt_subnet] do
  vpc node[:amd_infra_new][:vpc_name]
  cidr_block '173.0.1.0/24'
  route_table node[:amd_infra_new][:route_table]
  availability_zone node[:amd_infra_new][:availability_zone]
  map_public_ip_on_launch false
end

include_recipe "amd_medengine::default"
