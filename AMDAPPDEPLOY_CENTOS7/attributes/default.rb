#
# Cookbook Name:: AMDAPPDEPLOY_CENTOS7
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#
default[:AMDAPPDEPLOY_CENTOS7][:repouri] = 'http://cran.rstudio.com/bin/linux/ubuntu trusty'
default[:AMDAPPDEPLOY_CENTOS7][:amdapp_dir] = '/usr/share'
default[:AMDAPPDEPLOY_CENTOS7][:db_user] = 'root'
default[:AMDAPPDEPLOY_CENTOS7][:db_password] = 'root'
default[:AMDAPPDEPLOY_CENTOS7][:pythonpkg] = 'python'
default[:AMDAPPDEPLOY_CENTOS7][:version] = '2.7.0'
default[:AMDAPPDEPLOY_CENTOS7][:rpkg] = 'r-base'
default[:AMDAPPDEPLOY_CENTOS7][:mysqlversion] = '5.6'
default[:AMDAPPDEPLOY_CENTOS7][:port] = '3306'
default[:AMDAPPDEPLOY_CENTOS7][:db_name] = 'analyticsMD'
default[:AMDAPPDEPLOY_CENTOS7][:git_user] = 'rl-analyticsmd'
default[:AMDAPPDEPLOY_CENTOS7][:passwd] = 'ZAQ!2wsx'
default[:AMDAPPDEPLOY_CENTOS7][:packages] = ['epel-release','R','mariadb-server', 'mariadb', 'gcc', 'gcc-c++', 'kernel-devel', 'python-pip', 'git', 'mariadb-devel','mariadb-server', 'mariadb', 'python-devel', 'ncurses-devel', 'gcc', 'python-ldap', 'Cython', 'openldap-devel', 'pycrypto', 'expect', 'npm', 'libxslt-devel', 'libffi-devel', 'openssl-devel']
# default[:AMDAPPDEPLOY_CENTOS7][:dependencies] = ['npm', 'expect', 'gcc',  'python-dev', 'libldap2-dev', 'libssl-dev', 'build-essential', 'autoconf', 'libtool', 'pkg-config', 'python-opengl', 'python-imaging', 'python-pyrex', 'python-pyside.qtopengl', 'idle-python2.7', 'qt4-dev-tools', 'qt4-designer', 'libqtgui4', 'libqtcore4', 'libqt4-xml', 'libqt4-test', 'libqt4-script', 'libqt4-network', 'libqt4-dbus', 'python-qt4', 'python-qt4-gl', 'libgle3', 'python-dev', 'python-pip'
# ]
# default[:AMDAPPDEPLOY_CENTOS7][:depends_yum] = ['zlib-dev', 'python-devel', 'python-ldap', 'openssl-devel', 'sqlite-devel', 'bzip2-devel', ' ncurses-devel','gcc', 'mariadb-devel']