#
# Cookbook Name:: amdappdep
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

package 'epel-release'

package 'R'


execute "update" do
	command "yum -y update"
end

# execute "install R" do 
# 	command "yum install R"
# end
