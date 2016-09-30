#
# Cookbook Name:: AMD_sg
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#
require 'chef/provisioning/aws_driver'

with_driver 'aws'

aws_security_group node[:AMD_sg][:sg_name] do
  vpc node[:AMD_sg][:vpc_name]
  inbound_rules node[:AMD_sg][:inbound_rules]
  outbound_rules node[:AMD_sg][:outbound_rules]
end