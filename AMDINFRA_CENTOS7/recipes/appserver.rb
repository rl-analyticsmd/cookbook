#
# Cookbook Name:: AMDINFRA_CENTOS7
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

require 'chef/provisioning/aws_driver'

with_driver 'aws'

# nat_instance = search(:node, 'role:"nat_instance"').first


with_machine_options({
  convergence_options: {
    ssl_verify_mode: :verify_none,
    },
  bootstrap_options: {
    image_id: node[:AMDINFRA_CENTOS7][:ami_ID], 
    instance_type: node[:AMDINFRA_CENTOS7][:instance_type],
    key_name: node[:AMDINFRA_CENTOS7][:key_name], 
    key_path: node[:AMDINFRA_CENTOS7][:key_path],
    subnet_id: node[:AMDINFRA_CENTOS7][:subnet_ID],
    security_group_ids: node[:AMDINFRA_CENTOS7][:sg_ID]
    },
  ssh_username: "centos",
  # ssh_gateway: lazy { "#{user}@#{nat_instance['ec2']['public_ipv4']}" },
  ssh_gateway: "ec2-user@52.41.28.243",
  use_private_ip_for_ssh: true, 
  transport_address_location: :private_ip
})


machine node[:AMDINFRA_CENTOS7][:machine_name] do
  role 'appserver'
  tag 'medengineserver'
  converge true
  # action :converge_only
end
