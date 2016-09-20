default[:AMD_DB_SERVER][:pro_type] = 'test'
default[:AMD_DB_SERVER][:db_ami_ID] = 'ami-c7d092f7'
default[:AMD_DB_SERVER][:instance_type] = 't2.medium'
default[:AMD_DB_SERVER][:key_name] = 'amdkeypair'
default[:AMD_DB_SERVER][:key_path] = '~/.chef/keys/amdkeypair.pem'
default[:AMD_DB_SERVER][:pvt_subnet_ID] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_pvt_subnet"
default[:AMD_DB_SERVER][:sg_ID] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_sg"
default[:AMD_DB_SERVER][:ami_ID] = 'ami-c7d092f7'
default[:AMD_DB_SERVER][:nginx_ami_ID] = 'ami-9abea4fb'
default[:AMD_DB_SERVER][:pub_subnet_ID] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_pub_subnet"
default[:AMD_DB_SERVER][:nat_instance_tag] = "#{node[:AMD_DB_SERVER][:pro_type]}_nat_instance"
#################APPSERVER###############################
default[:AMD_DB_SERVER][:app_tag] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_app"
default[:AMD_DB_SERVER][:app_machine_name] = "#{node[:AMD_DB_SERVER][:pro_type]}_analyticsapp"

#################DBSERVER#####################
default[:AMD_DB_SERVER][:db_tag] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_db"
default[:AMD_DB_SERVER][:db_machine_name] = "#{node[:AMD_DB_SERVER][:pro_type]}_analytics_app"
default[:AMD_DB_SERVER][:ebs_volume] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_vol"
#############NGINXSERVER####################
default[:AMD_DB_SERVER][:nginx_machine_name] = "#{node[:AMD_DB_SERVER][:pro_type]}_amd_nginx"
default[:AMD_DB_SERVER][:nginx_tag] = "#{node[:AMD_DB_SERVER][:pro_type]}_analytics_nginx"
