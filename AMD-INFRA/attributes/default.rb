default[:AMD_INFRA][:pro_type]= 'bng_test'
default[:AMD_INFRA][:eip] = "#{node[:AMD_INFRA][:pro_type]}_eip"
default['AMD_INFRA']['vpc_name'] = "#{node[:AMD_INFRA][:pro_type]}_analyticsmd_vpc"
default['AMD_INFRA']['cidr_block'] = '173.0.0.0/16'
default[:AMD_INFRA][:cidr_block_pub] = '173.0.0.0/24'
default[:AMD_INFRA][:cidr_block_pvt] = '173.0.1.0/24'
default['AMD_INFRA']['aws_pub_subnet'] = "#{node[:AMD_INFRA][:pro_type]}_amd_pub_subnet"
default['AMD_INFRA']['availability_zone'] = 'us-west-2c'
default['AMD_INFRA']['security_group'] = "#{node[:AMD_INFRA][:pro_type]}_amd_sg"
default['AMD_INFRA']['key_name'] = 'amdkeypair'
default['AMD_INFRA']['key_path'] = '~/.chef/keys/amdkeypair'
default['AMD_INFRA']['instance_type'] = 't2.micro'
default['AMD_INFRA']['instance_name'] = "#{node[:AMD_INFRA][:pro_type]}_analytics_nat_instance"
default['AMD_INFRA']['route_table'] = "#{node[:AMD_INFRA][:pro_type]}_amd_route"
default['AMD_INFRA']['aws_pvt_subnet'] = "#{node[:AMD_INFRA][:pro_type]}_amd_pvt_subnet"
default['AMD_INFRA']['amd_image_id'] = 'ami-77a4b816'
default[:AMD_INFRA][:role]= "#{node[:AMD_INFRA][:pro_type]}_nat_instance"
default[:AMD_INFRA][:tag]= "#{node[:AMD_INFRA][:pro_type]}_nat_instance"
default[:AMD_INFRA][:routes] = {'0.0.0.0/0' => "#{node[:AMD_INFRA][:instance_name]}"}