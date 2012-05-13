#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "base::create_users"
include_recipe "ssh"
include_recipe "iptables"
include_recipe "ntp"
