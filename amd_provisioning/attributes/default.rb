#
# Cookbook Name:: amd_provisioning
# Recipe:: amd_provisioning
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
default[:amd_provisioning][:ami_ID] = 'ami-9abea4fb'
default[:amd_provisioning][:instance_type] = 't2.small'
default[:amd_provisioning][:key_name] = 'amdkeypair'
default[:amd_provisioning][:key_path] = '~/.chef/keys/amdkeypair.pem'
default[:amd_provisioning][:subnet_ID] = 'amd_pub_subnet'
default[:amd_provisioning][:sg_ID] = 'amd_sg'
default[:amd_provisioning][:machine_name] = 'analyticsmdapp'
# default[:amd_provisioning][:front_machine_name] = 'nginx_server'