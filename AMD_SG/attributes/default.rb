default[:AMD_sg][:pro_type] = 'security_test'
default[:AMD_sg][:sg_name] = "#{node[:AMD_sg][:pro_type]}_amd_sg"
default[:AMD_sg][:vpc_name] = "#{node[:AMD_sg][:pro_type]}_analyticsmd_vpc"
default[:AMD_sg][:inbound_rules] = {'0.0.0.0/0' => [ 22, 80 ]}
default[:AMD_sg][:outbound_rules] = {[ 22, 80 ] => '0.0.0.0/0'} 
# default[:AMD_sg][:source] = '0.0.0.0/0'


