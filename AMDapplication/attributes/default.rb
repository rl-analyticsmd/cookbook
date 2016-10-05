default[:AMDapplication][:pro_type]= 'test'
default[:AMDapplication][:repouri] = 'http://cran.rstudio.com/bin/linux/ubuntu trusty'
default[:AMDapplication][:amdapp_dir] = '/usr/share'
default[:AMDapplication][:db_user] = 'root'
default[:AMDapplication][:db_password] = 'root'
default[:AMDapplication][:pythonpkg] = 'python'
default[:AMDapplication][:version] = '2.7.0'
default[:AMDapplication][:rpkg] = 'r-base'
default[:AMDapplication][:mysqlversion] = '5.6'
default[:AMDapplication][:port] = '3306'
default[:AMDapplication][:db_name] = 'analyticsMD'
default[:AMDapplication][:git_user] = 'rl-analyticsmd'
default[:AMDapplication][:passwd] = 'ZAQ!2wsx'
default[:AMDapplication][:packages] = ['epel-release','R', 'gcc', 'gcc-c++', 'redis', 'kernel-devel', 'python-pip', 'git', 'mariadb-devel', 'python-devel', 'ncurses-devel', 'gcc', 'python-ldap', 'Cython', 'openldap-devel', 'pycrypto', 'expect', 'npm', 'wkhtmltopdf', 'libxslt-devel', 'libffi-devel', 'openssl-devel']
default[:AMDapplication][:dbserver_tag] = "#{node[:AMDapplication][:pro_test]}_amd_db"