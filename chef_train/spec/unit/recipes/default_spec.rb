#
# Cookbook Name:: chef_train
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef_train::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'installs httpd' do
      expect(chef_run).to install_package('httpd')
    end
it 'create dir' do
expect(chef_run).to create_directory('tmp/training')
end
  end
end
