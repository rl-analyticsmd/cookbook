#
# Cookbook Name:: AMD_ebs_volume
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

require 'chef/provisioning/aws_driver'

with_driver 'aws'

aws_ebs_volume 'amd_ebs_vol' do
  machine 'dbserver1'
  availability_zone 'c'
  size 20
  iops 600
  volume_type 'io1'
  encrypted true
  device '/dev/sda2'
  aws_tags :chef_type => 'aws_ebs_volume'
end