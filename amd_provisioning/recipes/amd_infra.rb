#
# Cookbook Name:: amd_provisioning
# Recipe:: amd_provisioning
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
    image_id: node[:amd_provisioning][:ami_ID], 
    instance_type: node[:amd_provisioning][:instance_type],
    key_name: node[:amd_provisioning][:key_name], 
    key_path: node[:amd_provisioning][:key_path],
    subnet_id: node[:amd_provisioning][:subnet_ID],
    security_group_ids: node[:amd_provisioning][:sg_ID]
      },
  use_private_ip_for_ssh: false, 
  transport_address_location: :public_ip,
})

machine node[:amd_provisioning][:machine_name] do
  recipe 'AMDppdeploy'
  tag 'amd_ops'
  converge true
end
