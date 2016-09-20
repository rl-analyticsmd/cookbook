#
# Cookbook Name:: AMD_DB_SERVER
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "AMD_DB_SERVER::dbserver"
include_recipe "AMD_DB_SERVER::appserver"
include_recipe "AMD_DB_SERVER::nginxserver"