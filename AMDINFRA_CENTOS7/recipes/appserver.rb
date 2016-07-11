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
  use_private_ip_for_ssh: false, 
  transport_address_location: :public_ip,
})

machine node[:AMDINFRA_CENTOS7][:machine_name] do
  role 'appserver'
  tag 'amd_ops'
  converge true
end
