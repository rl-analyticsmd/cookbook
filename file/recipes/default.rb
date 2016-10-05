#
# Cookbook Name:: file
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

file '/root/abc/sample.txt' do
  content 'This is Relevance Lab.'
  mode '0755'
end

execute 'This a sample file to create.' do
  command 'touch /root/abc/file{1..5}'
end