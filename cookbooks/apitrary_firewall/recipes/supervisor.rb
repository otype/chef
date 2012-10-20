#
# Cookbook Name:: apitrary_firewall
# Recipe:: supervisor
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow Supervisor XML-RPC connection
simple_iptables_rule "system" do
  rule "-p tcp --dport 9001"
  jump "ACCEPT"
end