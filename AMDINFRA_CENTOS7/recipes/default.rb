#
# Cookbook Name:: AMDINFRA_CENTOS7
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'AMD_INFRA::default'
include_recipe 'AMDINFRA_CENTOS7::appserver'
include_recipe 'AMDINFRA_CENTOS7::nginx_server'