#
# Cookbook Name:: apitrary_firewall
# Recipe:: default
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"
include_recipe "apitrary_firewall::ssh"
include_recipe "apitrary_firewall::slicehost_defaults"
