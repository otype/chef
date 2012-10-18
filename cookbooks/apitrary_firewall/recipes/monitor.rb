#
# Cookbook Name:: apitrary_firewall
# Recipe:: ssh
#
# Copyright 2012, apitrary
#
# All rights reserved - Do Not Redistribute
#

include_recipe "simple_iptables"

# Allow HTTP/HTTPS
simple_iptables_rule "system" do
  rule [
           "-p tcp --dport 80",
           "-p tcp --dport 443"
       ]
  jump "ACCEPT"
end