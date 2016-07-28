default[:amd_medengine][:db_ami_ID] = 'ami-c7d092f7'
default[:amd_medengine][:instance_type] = 't2.medium'
default[:amd_medengine][:key_name] = 'amdkeypair'
default[:amd_medengine][:key_path] = '~/.chef/keys/amdkeypair.pem'
default[:amd_medengine][:pvt_subnet_ID] = 'amd_pvt_subnet'
default[:amd_medengine][:sg_ID] = 'amd_sg'
default[:amd_medengine][:ami_ID] = 'ami-c7d092f7'
default[:amd_medengine][:nginx_ami_ID] = 'ami-9abea4fb'
default[:amd_medengine][:pub_subnet_ID] = 'amd_pub_subnet'
default[:amd_medengine][:vpc_name] = 'analyticsmd_vpc'
#################APPSERVER###############################
default[:amd_medengine][:amd_app_sg] = 'amd_app_sg'
default[:amd_medengine][:app_tag] = 'demo-app'
default[:amd_medengine][:app_machine_name] = 'demo-medengine_app'

#################DBSERVER#####################
default[:amd_medengine][:amd_db_sg] = 'amd_db_sg'
default[:amd_medengine][:db_tag] = 'demo-db'
default[:amd_medengine][:db_machine_name] = 'demo-medengine_db'
default[:amd_medengine][:ebs_volume] = 'amd_db_volume'
#############NGINXSERVER####################
default[:amd_medengine][:amd_nginx_sg] = 'amd_nginx_sg'
default[:amd_medengine][:nginx_machine_name] = 'demo-medengine_nginx'
default[:amd_medengine][:nginx_tag] = 'demo-nginx'
