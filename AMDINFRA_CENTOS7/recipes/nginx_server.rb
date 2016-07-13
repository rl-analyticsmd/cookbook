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
    image_id: node[:AMDINFRA_CENTOS7][:nginx_ami_ID], 
    instance_type: node[:AMDINFRA_CENTOS7][:instance_type],
    key_name: node[:AMDINFRA_CENTOS7][:key_name], 
    key_path: node[:AMDINFRA_CENTOS7][:key_path],
    subnet_id: node[:AMDINFRA_CENTOS7][:pub_subnet_ID],
    security_group_ids: node[:AMDINFRA_CENTOS7][:sg_ID]
      },
  use_private_ip_for_ssh: false, 
  transport_address_location: :public_ip,
    })

machine node[:AMDINFRA_CENTOS7][:nginx_machine_name] do
	recipe 'AMD_nginx'
  tag 'amd_nginx'
  converge true
end