#
# Cookbook Name:: chef_train
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package node ['chef_train']['package']
package 'git'
package 'vagrant'

directory 'tmp/training' do
action :create
end