#
# Cookbook Name:: apitrary_firewall
# Recipe:: web
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow Launchpad
simple_iptables_rule "system" do
  rule "-p tcp --dport 3000"
  jump "ACCEPT"
end