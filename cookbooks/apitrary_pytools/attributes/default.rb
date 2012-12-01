#
# Cookbook Name:: apitrary_pytools
# attributes:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
default['apitrary_pytools']['deployr']['repo'] = "git@github.com:apitrary/deployr.git"
default['apitrary_pytools']['deployr']['deployment_dir'] = "/home/deployr/deployment"

default['apitrary_pytools']['genapi']['repo'] = "git@github.com:apitrary/pygenapi.git"
default['apitrary_pytools']['genapi']['deployment_dir'] = "/home/genapi/deployment"

default['deployr']['dev']['SUPERVISORD_HOST'] = '1.1.1.1'
default['deployr']['dev']['SUPERVISORD_WEB_PORT'] = 9001
default['deployr']['dev']['SUPERVISOR_XML_RPC_USERNAME'] = 'NOTSET'
default['deployr']['dev']['SUPERVISOR_XML_RPC_PASSWORD'] = 'NOTSET'
default['deployr']['dev']['SUPERVISOR_XML_RPC_SERVER_ADDRESS'] = 'http://NOTSET:NOTSET@1.1.1.1:9001/RPC2'
default['deployr']['dev']['BROKER_USER'] = 'NOTSET'
default['deployr']['dev']['BROKER_PASSWORD'] = 'NOTSET'
default['deployr']['dev']['BROKER_PREFETCH_COUNT'] = false
default['deployr']['dev']['BROKER_HOST'] = '2.2.2.2'
default['deployr']['dev']['BROKER_PORT'] = 5672
default['deployr']['dev']['LOGGING'] = 'debug'
default['deployr']['dev']['DEPLOYR_CONFIG_FILE'] = '/etc/deployr/deployr.conf'
