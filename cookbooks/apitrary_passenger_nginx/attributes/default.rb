#
# Cookbook Name:: apitrary_nginx
# attributes:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#
default['passenger_nginx']['passenger_version'] = "3.0.17"
default['passenger_nginx']['prefix'] = "/opt/nginx"
default['passenger_nginx']['worker_processes'] = "4"
default['passenger_nginx']['binary'] = "/opt/nginx/sbin/nginx"
default['passenger_nginx']['pid'] = "/opt/nginx/logs/nginx.pid"
default['passenger_nginx']['port'] = 8080

# Hostnames
default['passenger_nginx']['hostnames']['launchpad']['dev'] = "launchpad.dev.apitrary.com"
default['passenger_nginx']['hostnames']['launchpad']['live'] = "launchpad.apitrary.com"
default['passenger_nginx']['hostnames']['www']['dev'] = "www.dev.apitrary.com"
default['passenger_nginx']['hostnames']['www']['live_long'] = "www.apitrary.com"
default['passenger_nginx']['hostnames']['www']['live'] = "apitrary.com"

# Needed for Nginx source installation
default['passenger_nginx']['version'] = "1.2.6"
