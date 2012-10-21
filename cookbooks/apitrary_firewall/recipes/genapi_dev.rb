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
  rule [
           "-p tcp --dport 7000",
           "-p tcp --dport 7001",
           "-p tcp --dport 7002",
       ]
  jump "ACCEPT"
end