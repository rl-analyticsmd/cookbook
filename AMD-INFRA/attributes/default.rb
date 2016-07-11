default['AMD_INFRA']['vpc_name'] = 'analyticsmd_vpc'
default['AMD_INFRA']['cidr_block'] = '173.0.0.0/16'
default['AMD_INFRA']['aws_pub_subnet'] = 'amd_pub_subnet'
default['AMD_INFRA']['availability_zone'] = 'us-west-2c'
default['AMD_INFRA']['security_group'] = 'amd_sg'
default['AMD_INFRA']['key_name'] = 'amdkeypair'
default['AMD_INFRA']['key_path'] = '~/.chef/keys/amdkeypair'
default['AMD_INFRA']['instance_type'] = 't2.micro'
default['AMD_INFRA']['instance_name'] = 'analyticsmd_nat_instance'
default['AMD_INFRA']['route_table'] = 'amd_route'
default['AMD_INFRA']['aws_pvt_subnet'] = 'amd_pvt_subnet'